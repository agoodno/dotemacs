(use-package robe
  :ensure t
  :init
  (progn (add-hook 'ruby-mode-hook 'robe-mode)))

(provide 'agg-robe)
