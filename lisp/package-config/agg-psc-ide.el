(use-package psc-ide
  :ensure t
  :defer t
  :init
    (add-hook 'purescript-mode-hook
      (lambda ()
        (psc-ide-mode)
        (turn-on-purescript-indentation))))

;;        (flycheck-mode)

(provide 'agg-psc-ide)
