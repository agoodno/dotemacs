(use-package scala-mode
  :ensure t
  :defer t
  :pin melpa-stable
  :init (add-to-list 'auto-mode-alist '("\\.sbt$" . scala-mode))
        (add-hook 'scala-mode-hook 'progmodes-hooks)
  :interpreter ("scala" . scala-mode))

(provide 'agg-scala-mode)
