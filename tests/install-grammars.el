;;; install-grammars.el --- Install declared tree-sitter grammars  -*- lexical-binding: t; -*-

;; Run after the config is loaded:
;;
;;   emacs --batch -l init.el -l tests/install-grammars.el
;;
;; Kept as a file rather than an inline --eval: a multi-line form inside a
;; single-quoted shell argument keeps its backslash continuations literal, and
;; Emacs then reads "\" as a variable and dies with (void-variable \).
;;
;; Needed on a fresh machine and in CI. The tree-sitter remaps in config.org are
;; guarded on treesit-ready-p, so with no grammars the config silently falls back
;; to the classic modes -- which looks fine until the mode-dispatch tests start
;; asserting against the wrong modes.

;; Grammars named in GRAMMARS_ALLOW_FAILURE (comma-separated) are reported but
;; do not fail the run. Needed for grammars with C++ scanners on hosts where the
;; C++ runtime cannot be made visible to Emacs -- a nix-installed Emacs cannot
;; take LD_LIBRARY_PATH pointing at the system lib directory, because that
;; shadows glibc as well and Emacs then refuses to start. The mode-dispatch test
;; skips any extension whose grammar is not ready, so coverage stays honest
;; rather than silently asserting the wrong mode.
(defvar install-grammars--tolerated
  (let ((raw (getenv "GRAMMARS_ALLOW_FAILURE")))
    (if (and raw (not (string-empty-p raw)))
        (mapcar #'intern (split-string raw "," t "[ \t]+"))
      '())))

(let ((failed '())
      (installed '())
      (present '()))
  (dolist (src treesit-language-source-alist)
    (let ((lang (car src)))
      (if (treesit-ready-p lang t)
          (push lang present)
        (condition-case err
            (progn
              (message "installing grammar: %s" lang)
              (treesit-install-language-grammar lang)
              (if (treesit-ready-p lang t)
                  (push lang installed)
                (push (cons lang "installed but still not ready") failed)))
          (error (push (cons lang (error-message-string err)) failed))))))
  (message "grammars already present: %s" (nreverse present))
  (message "grammars installed now:   %s" (nreverse installed))
  (when failed
    (setq failed (nreverse failed))
    (message "grammars FAILED:")
    (dolist (f failed)
      (message "  %s: %s%s" (car f) (cdr f)
               (if (memq (car f) install-grammars--tolerated) " [tolerated]" "")))
    (let ((fatal (seq-remove (lambda (f)
                               (memq (car f) install-grammars--tolerated))
                             failed)))
      (when fatal
        (message "%d grammar(s) failed and are not tolerated" (length fatal))
        (kill-emacs 1)))
    (message "all failures tolerated via GRAMMARS_ALLOW_FAILURE")))
