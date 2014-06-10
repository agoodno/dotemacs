;; mbp specific settings

;; switch default key bindings
;(setq mac-right-option-modifier 'control)

;; Above was my first attempt to get a control key on the right side

;; I ended up switching the modifier keys in the Keyboard control panel
;;  Command becomes Alt
;;  Alt becomes Command
;; Doing it this way the command-line editing is identical to Emacs
;;
;; On the Keyboard tab, also set "Use all F1, F2, etc. as standard function keys..." = true
;;
;; And on the Shortcuts tab, unchecked almost all keyboard shortcuts

;; This made it so the mac settings were not needed (as the keys were
;; already flipped at the OS-level. Having them in the emacs config
;; would have flipped them again.

;; Using KeyRemap4MacBook to re-map Left Arrow to be my Right Cntl Key

;; iTerm, set "Use option as meta key" = true

;; Last issue is the function key. I often hit it when I want my Left Cntl Key so I'd like to swap Function and Left Cntl.

(set-face-attribute 'default nil :family "Monaco" :height 106 :weight 'normal)

; default
; (set-background-color "white")
; (set-foreground-color "black")

; reverse-video
(set-foreground-color "white")
(set-background-color "black")

(shell-dir "cmd-customerservice" "/Users/agoodnough/src/customerservice/")
(shell-dir "cmd-onevueapi" "/Users/agoodnough/src/onevueapi/")
(shell-dir "cmd-rails" "/Users/agoodnough/src/rails/")
(shell-dir "run-backend" "/Users/agoodnough/src/customerservice/")
(shell-dir "run-frontend" "/Users/agoodnough/src/onevueweb/")

;; (shell "cmd-customerservice")
;; (shell "cmd-onevueapi")
;; (shell "cmd-rails")
;; (shell "backend")
;; (shell "frontend")

(global-set-key (kbd "C-x C-l")
  (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([134217847 16 5 return 112 117 116 115 32 34 25 61 35 123 25 125 34] 0 "%d")) arg)))
