(use-package erc-hipchatify
  :ensure t
  :init
  (progn
    (add-to-list 'erc-modules 'hipchatify)
    (erc-update-modules)))

(provide 'agg-erc-hipchatify)
