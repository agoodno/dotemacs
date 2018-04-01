(use-package company-tern
  :ensure t
  :defer t
  :init
    (with-eval-after-load 'company
      (add-to-list 'company-backends 'company-tern)))

;;    (add-hook 'js2-mode-hook (lambda () (tern-mode) (company-mode)))

(provide 'agg-company-tern)
