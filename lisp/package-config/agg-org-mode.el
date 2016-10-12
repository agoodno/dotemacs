;; Distributed with GNU Emacs

(setq org-log-done 'time)
(setq org-log-done 'note)

;; #+TODO: TODO(t) STARTED(s) WAITING(w) | DONE(d) CANCELED(c)
(setq org-todo-keywords
       '((sequence "TODO" "PROGRAMMING" "DESIGNING" "WAITING" "CHECKLIST" "PR" "APPROVED" "|" "MERGED" "DELEGATED" "DONE" "CANCELED")))
(setq org-log-done nil)

(provide 'agg-org-mode)
