(use-package json-mode
  :ensure t
  :defer t
  :init (add-hook 'json-mode-hook '(lambda ()
          (setq indent-tabs-mode nil)
          (setq tab-width 2)
          (setq indent-line-function (quote insert-tab))
          (local-set-key (kbd "C-c C-f") 'json-pretty-print-buffer))))


(provide 'agg-json-mode)
