;; Distributed with GNU Emacs

(setq auto-mode-alist (cons '("\\.psql$" . sql-mode) auto-mode-alist))

(add-hook 'sql-mode-hook 'turn-off-auto-fill)
(add-hook 'sql-mode-hook 'progmodes-hooks)

(provide 'agg-sql-mode)
