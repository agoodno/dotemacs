(setq user-full-name "Andrew Goodnough"
      user-mail-address "agoodno@gmail.com")

;;(setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))

(setq exec-path (append exec-path '("/usr/local/bin")))
;;(setq exec-path (append exec-path '("/Users/agoodnough/bin")))
(setq exec-path (append exec-path (list (concat (getenv "HOME") "/bin"))))

(setenv "PAGER" "/bin/cat")

;; Changes backups to go to a backup directory
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))

(add-to-list 'auto-mode-alist '("\\.log\\'" . auto-revert-mode))

(provide 'agg-misc)
