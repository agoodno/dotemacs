(use-package psc-ide
  :ensure t
  :defer t
  :init
    (add-hook 'purescript-mode-hook
      (lambda ()
        (psc-ide-mode)
        (company-mode)
        (flycheck-mode)
        (turn-on-purescript-indentation))))

(provide 'agg-psc-ide)
