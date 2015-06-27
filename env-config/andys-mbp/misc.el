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

;; reverse-video
(set-foreground-color "white")
(set-background-color "black")

;; (eval-after-load 'magit
;;   '(progn
;;      (set-face-foreground 'magit-diff-add "green4")
;;      (set-face-foreground 'magit-diff-del "red3")
;;      (set-face-background 'magit-item-highlight "#000000")
;; ;     (set-face-foreground 'magit-item-highlight "#FFFFFF")
;;      (set-face-foreground 'diff-context "#777777")
;;      (set-face-background 'diff-added "#000000")
;;      (set-face-background 'diff-removed "#000000")
;;      (set-face-background 'diff-file-header "#000000")
;;      (set-face-foreground 'magit-log-head-label-default "#000000")
;;      (set-face-background 'magit-log-head-label-default "grey")
;;      (set-face-foreground 'magit-log-head-label-head "#000000")
;;      (set-face-background 'magit-log-head-label-head "grey")
;;      (set-face-foreground 'magit-log-head-label-local "#000000")
;;      (set-face-background 'magit-log-head-label-local "grey")
;;      (set-face-foreground 'magit-log-head-label-remote "#000000")
;;      (set-face-background 'magit-log-head-label-remote "grey")
;;      (set-face-foreground 'magit-log-head-label-wip "#000000")
;;      (set-face-background 'magit-log-head-label-wip "grey")))

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

(setq visible-bell 1)

;; (set-foreground-color "black")
;; (set-background-color "lightyellow")

;; (eval-after-load 'magit
;;   '(progn
;;      (set-face-foreground 'magit-diff-add "darkgreen")
;;      (set-face-foreground 'magit-diff-del "darkred")
;;      (set-face-background 'magit-item-highlight "lightyellow")
;;      (set-face-foreground 'diff-context "darkgrey")
;;      (set-face-background 'diff-added "lightgrey")
;;      (set-face-background 'diff-removed "lightgrey")
;;      (set-face-background 'diff-file-header "darkgrey")
;;      (set-face-background 'magit-log-head-label-remote "lightyellow")))

;; (set-face-attribute  'mode-line
;;                      nil
;;                      :foreground "gray80"
;;                      :background "gray25"
;;                      :box '(:line-width 1 :style released-button))
;; (set-face-attribute  'mode-line-inactive
;;                      nil
;;                      :foreground "gray25"
;;                      :background "gray80"
;;                      :box '(:line-width 1 :style released-button))


(shell-dir "cmd-customerservice" "/Users/agoodnough/src/customerservice/")
(shell-dir "cmd-deviceapi" "/Users/agoodnough/src/deviceapi/")
(shell-dir "cmd-notificationservice" "/Users/agoodnough/src/notificationservice/")
(shell-dir "cmd-onevueapi" "/Users/agoodnough/src/onevueapi/")
(shell-dir "cmd-rails" "/Users/agoodnough/src/rails/")
(shell-dir "procs" "/Users/agoodnough/src/customerservice/")
(shell-dir "cmd-clockstatusesprocessor" "/Users/agoodnough/src/ov-clockstatusesprocessor/")
(shell-dir "cmd-readingsprocessor" "/Users/agoodnough/src/ov-readingsprocessor/")
(shell-dir "cmd-twilioprocessor" "/Users/agoodnough/src/ov-twilioprocessor/")
(shell-command "java -jar /Users/agoodnough/opt/dynamodb_local/DynamoDBLocal.jar --port 4567 &")
(shell-command "java -jar /Users/agoodnough/opt/dynamodb_local/DynamoDBLocal.jar --port 5678 &")

;; (shell-dir "run-frontend" "/Users/agoodnough/src/onevueweb/")

;; (shell "cmd-customerservice")
;; (shell "cmd-onevueapi")
;; (shell "cmd-rails")
;; (shell "backend")
;; (shell "frontend")

(global-set-key (kbd "C-x C-l")
  (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([134217847 16 5 return 112 117 116 115 32 34 25 61 35 123 25 125 34] 0 "%d")) arg)))
