(use-package tern
  :ensure t
  :defer t
  :init
    (add-to-list 'load-path "/home/agoodno/src/tern/emacs/")
    (autoload 'tern-mode "tern.el" nil t)
    (add-hook 'js2-mode-hook (lambda () (tern-mode t))))

;; (eval-after-load 'tern
;;    '(progn
;;       (require 'tern-auto-complete)
;;       (tern-ac-setup)))

;;(define-key tern-mode-keymap (kbd "M-.") nil)
;;(define-key tern-mode-keymap (kbd "M-,") nil)

(provide 'agg-tern)
