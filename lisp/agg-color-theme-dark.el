(set-face-attribute 'default nil :family "Monaco" :height 106 :weight 'normal)

;; reverse-video

;; Setting this on the frame-level allows for new frames opened to
;; automatically take on the same color scheme
(add-to-list 'default-frame-alist '(foreground-color . "white"))
(add-to-list 'default-frame-alist '(background-color . "black"))
(add-to-list 'default-frame-alist '(cursor-color . "white"))

;; Didn't work with multiple frames, but useful for ad-hoc switching
(set-foreground-color "white")
(set-background-color "black")

(set-face-attribute  'mode-line-inactive
                     nil
                     :foreground "gray80"
                     :background "gray25"
                     :box '(:line-width 1 :style released-button))
(set-face-attribute  'mode-line
                     nil
                     :foreground "gray25"
                     :background "gray80"
                     :box '(:line-width 1 :style released-button))

(provide 'agg-color-theme-dark)
