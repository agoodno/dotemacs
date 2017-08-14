(use-package json-mode
  :ensure t
  :defer t
  ;; Shows an example of how to set a Customize variable individually
  ;; instead of in agg-custom.el
  :init (customize-set-variable 'json-reformat:indent-width 2))

(provide 'agg-json-mode)
