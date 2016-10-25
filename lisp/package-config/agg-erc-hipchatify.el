(use-package erc-hipchatify
  :ensure t
  :defer t
  :init
  (progn
    ;; (customize-set-variable 'shr-use-fonts f)
    ;; (customize-set-variable 'shr-external-browser "")
    (add-to-list 'erc-modules 'hipchatify)
    (erc-update-modules)))

(provide 'agg-erc-hipchatify)
