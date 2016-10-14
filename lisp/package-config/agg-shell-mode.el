;; Distributed with GNU Emacs

;;; Fix junk characters in shell-mode
;; Add color to a shell running in emacs 'M-x shell'
;;; Shell mode
(setq ansi-color-names-vector ; better contrast colors
      ["black" "red4" "green4" "yellow4"
       "blue3" "magenta4" "cyan4" "white"])
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; #+TODO: TODO(t) STARTED(s) WAITING(w) | DONE(d) CANCELED(c)
(setq org-todo-keywords
       '((sequence "TODO" "PROGRAMMING" "DESIGNING" "WAITING" "CHECKLIST" "PR" "APPROVED" "|" "MERGED" "DELEGATED" "DONE" "CANCELED")))
(setq org-log-done nil)

;; Makes the prompt read-only running in emacs 'M-x shell'
(add-hook 'shell-mode-hook
     '(lambda () (toggle-truncate-lines 1)))
(setq comint-prompt-read-only t)

;; Makes the prompt read-only running in emacs 'M-x shell'
(add-hook 'shell-mode-hook
     '(lambda () (toggle-truncate-lines 1)))
(setq comint-prompt-read-only t)

(provide 'agg-shell-mode)