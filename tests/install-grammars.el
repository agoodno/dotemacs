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
    (message "grammars FAILED:")
    (dolist (f (nreverse failed))
      (message "  %s: %s" (car f) (cdr f)))
    (kill-emacs 1)))
