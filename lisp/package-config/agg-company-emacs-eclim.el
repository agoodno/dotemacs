(use-package company-emacs-eclim
  :ensure t
  :config
  (with-eval-after-load 'company
    (add-to-list 'company-backends 'company-emacs-eclim)
    (company-emacs-eclim-setup)))

(provide 'agg-company-emacs-eclim)
