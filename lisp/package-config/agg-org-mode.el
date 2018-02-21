;; Distributed with GNU Emacs

(setq org-log-done 'time)
(setq org-log-done 'note)

;; #+TODO: TODO(t) STARTED(s) WAITING(w) | DONE(d) CANCELED(c)
(setq org-todo-keywords
       '((sequence "IDEA" "TODO" "PLANNING" "DESIGNING" "PROGRAMMING" "WAITING" "TESTING" "CHECKLIST" "MR" "APPROVED" "|" "MERGED" "DELEGATED" "DONE" "CANCELED")))
(setq org-log-done nil)

(provide 'agg-org-mode)
