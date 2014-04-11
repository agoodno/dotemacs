;; mac specific settings

;; sets fn-delete to be right-delete
(global-set-key [kp-delete] 'delete-char)

;; fixes hang in commit-mode because it can't find emacsclient
(setq magit-emacsclient-executable "/usr/local/bin/emacsclient")
