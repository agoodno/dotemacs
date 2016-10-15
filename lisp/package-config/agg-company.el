(use-package company
  :ensure t
  :init
  (progn (global-company-mode t)
         (push 'company-robe company-backends)))

(provide 'agg-company)
