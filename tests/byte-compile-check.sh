#!/usr/bin/env bash
# Tangle config.org, byte-compile the result, and compare the warnings against
# tests/warning-baseline.txt.
#
#   ./tests/byte-compile-check.sh            fail on any NEW warning
#   ./tests/byte-compile-check.sh --update   rewrite the baseline from current output
#
# Rationale: this config has ~49 long-standing warnings, most of them the benign
# "assignment to free variable" kind that comes from setting an option before its
# library loads. Demanding zero warnings would mean either a huge cleanup first or
# ignoring warnings forever. Comparing against a committed baseline instead makes
# any *newly introduced* warning a build failure while leaving the backlog visible.
#
# Positions are stripped from each warning so the baseline survives line-number
# churn in config.org; only the message text is compared.
#
# The exact warning set is mildly environment-dependent: which libraries happen
# to be loaded when the compiler runs affects the "free variable" warnings, so a
# CI runner can legitimately produce a slightly different set than a workstation
# (observed: auto-revert-use-notify warns locally but not on a bare checkout).
# Only NEW warnings fail, so a smaller set on CI is harmless -- it just prints
# the "fixed since baseline" note. If CI ever reports a warning that does not
# reproduce locally, add it to the baseline rather than chasing it.

set -uo pipefail

# comm requires both inputs collated identically. The warnings contain curly
# quotes, so locale-dependent collation makes a baseline written on one machine
# unusable on another -- it shows every line as simultaneously added and removed.
# LC_ALL=C pins byte order everywhere sort and comm are used.
export LC_ALL=C

cd "$(dirname "$0")/.." || exit 1
EMACS="${EMACS:-emacs}"
BASELINE="tests/warning-baseline.txt"
WORK="$(mktemp -d)"
trap 'rm -rf "$WORK"' EXIT

# Tangle. This also proves the literate config still tangles cleanly.
#
# The language regexp must match what `org-babel-load-file' itself uses, or we
# would compile code Emacs never loads. Without it the non-elisp blocks (the
# "customize-group RET agg" bash snippet) get tangled in too and generate
# phantom warnings. With "emacs-lisp\\|elisp" the output is byte-identical to
# the config.el that init.el actually loads.
"$EMACS" --batch \
  --eval "(require 'org)" \
  --eval "(org-babel-tangle-file \"config.org\" \"$WORK/cfg.el\" \"emacs-lisp\\\\|elisp\")" \
  </dev/null >"$WORK/tangle.log" 2>&1
if [ ! -s "$WORK/cfg.el" ]; then
  echo "FAIL: config.org did not tangle to a non-empty file" >&2
  cat "$WORK/tangle.log" >&2
  exit 1
fi

# Byte-compile. stdin is closed deliberately: vterm prompts
# "Vterm needs 'vterm-module' to work. Compile it now? (y or n)" and would
# otherwise hang the run forever.
"$EMACS" --batch -l package --eval '(package-initialize)' \
  -f batch-byte-compile "$WORK/cfg.el" </dev/null >"$WORK/compile.log" 2>&1

# Keep only genuine "file:line:col: Warning|Error" diagnostics, then drop the
# position. Incidental chatter (the vterm prompt, load messages) has no such
# prefix and is filtered out here.
grep -E '\.el:[0-9]+:[0-9]+: (Warning|Error)' "$WORK/compile.log" \
  | sed -E 's/^.*\.el:[0-9]+:[0-9]+: //' \
  | sort >"$WORK/current.txt"

if [ "${1:-}" = "--update" ]; then
  cp "$WORK/current.txt" "$BASELINE"
  echo "Baseline updated: $(wc -l <"$BASELINE" | tr -d ' ') warnings"
  exit 0
fi

if [ ! -f "$BASELINE" ]; then
  echo "FAIL: $BASELINE missing. Run with --update to create it." >&2
  exit 1
fi

# New warnings fail the build. Warnings that disappeared do not -- they are
# progress -- but they are reported so the baseline can be tightened.
NEW="$(comm -13 "$BASELINE" "$WORK/current.txt")"
GONE="$(comm -23 "$BASELINE" "$WORK/current.txt")"

if [ -n "$GONE" ]; then
  echo "Warnings fixed since the baseline was taken (run --update to tighten it):"
  echo "$GONE" | sed 's/^/  - /'
  echo
fi

if [ -n "$NEW" ]; then
  echo "FAIL: new byte-compile warnings introduced:" >&2
  echo "$NEW" | sed 's/^/  + /' >&2
  exit 1
fi

echo "PASS: no new byte-compile warnings ($(wc -l <"$WORK/current.txt" | tr -d ' ') total, baseline $(wc -l <"$BASELINE" | tr -d ' '))"
