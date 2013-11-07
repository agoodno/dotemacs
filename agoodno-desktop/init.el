;; custom for agoodno-desktop
;(add-to-list 'default-frame-alist '(height . 70))
;(add-to-list 'default-frame-alist '(width . 150))

(global-set-key (kbd "C-x C-l")
  (lambda (&optional arg)
    "Keyboard macro."
    (interactive "p")
    (kmacro-exec-ring-item (quote ([134217847 16 5 return 108 111 103 103 101 114 46 100 101 98 117 103 40 34 25 61 37 115 34 46 102 111 114 109 97 116 40 25 41 41] 0 "%d")) arg)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(blink-cursor-mode nil)
 '(column-number-mode t)
 '(inhibit-startup-screen t)
 '(initial-scratch-message nil)
 '(scroll-bar-mode (quote right)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "black" :foreground "white" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 98 :width normal :foundry "unknown" :family "Ubuntu Mono")))))
