EMACS ?= emacs

.PHONY: help check lint test tangle baseline grammars clean-tangle

help:
	@echo "make check     - lint + test (what CI runs)"
	@echo "make lint      - byte-compile config.org, fail on NEW warnings"
	@echo "make test      - load the config and run the ERT suite"
	@echo "make tangle    - tangle config.org to config.el"
	@echo "make grammars  - install every tree-sitter grammar the config declares"
	@echo "make baseline  - re-record the byte-compile warning baseline"

check: lint test

lint:
	./tests/byte-compile-check.sh

# stdin is closed: vterm otherwise prompts to build its native module and hangs.
test:
	$(EMACS) --batch -l init.el -l tests/config-test.el \
	  -f ert-run-tests-batch-and-exit </dev/null

tangle:
	$(EMACS) --batch --eval "(require 'org)" \
	  --eval '(org-babel-tangle-file "config.org" "config.el" "emacs-lisp\\|elisp")'

baseline:
	./tests/byte-compile-check.sh --update

# Needed on a fresh machine and in CI: the tree-sitter remaps are guarded on
# treesit-ready-p, so without grammars the config silently falls back to the
# classic modes and the mode-dispatch tests fail.
grammars:
	$(EMACS) --batch -l init.el --eval '(dolist (src treesit-language-source-alist) \
	  (unless (treesit-ready-p (car src) t) \
	    (message "installing %s" (car src)) \
	    (treesit-install-language-grammar (car src))))' </dev/null

clean-tangle:
	rm -f config.el config.elc
