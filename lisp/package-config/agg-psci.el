(use-package psci
  :ensure t
  :defer t
  :init (add-hook 'purescript-mode-hook 'inferior-psci-mode))

(provide 'agg-psci)
