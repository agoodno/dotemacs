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

;; (shell-dir "cmd-py" "/Users/agoodnough/src/OVSensorReadingsProcessor/")
;; (shell-dir "cmd-customerservice" "/Users/agoodnough/src/customerservice/")
;; (shell-dir "cmd-deviceapi" "/Users/agoodnough/src/deviceapi/")
;; (shell-dir "cmd-notificationservice" "/Users/agoodnough/src/notificationservice/")
;; (shell-dir "cmd-mar-api" "/Users/agoodnough/src/mar-api/")
;; (shell-dir "cmd-mar-hubapi" "/Users/agoodnough/src/mar-hubapi/")
;; (shell-dir "cmd-onevueapi" "/Users/agoodnough/src/onevueapi/")
;; (shell-dir "cmd-rails" "/Users/agoodnough/src/rails/")
;; (shell-dir "procs" "/Users/agoodnough/src/customerservice/")
;; (shell-dir "cmd-clockstatusesprocessor" "/Users/agoodnough/src/ov-clockstatusesprocessor/")
;; (shell-dir "cmd-readingsprocessor" "/Users/agoodnough/src/ov-readingsprocessor/")
;; (shell-dir "cmd-twilioprocessor" "/Users/agoodnough/src/ov-twilioprocessor/")
(defun init-dynamo-dbs ()
  (interactive)
  (init-dynamo-db 4567 "DynamoDBLocal-Dev")
  (init-dynamo-db 5678 "DynamoDBLocal-Test"))

(defun init-dynamo-db (port buffer-name)
  (async-shell-command (format "java -Djava.library.path=/Users/agoodnough/opt/dynamodb_local/latest/DynamoDBLocal_lib -jar /Users/agoodnough/opt/dynamodb_local/latest/DynamoDBLocal.jar -dbPath /Users/agoodnough/opt/dynamodb_local/dbs/dev -port %d" port) buffer-name)
  (bury-buffer buffer-name))


;; (shell-dir "run-frontend" "/Users/agoodnough/src/onevueweb/")

;; (shell "cmd-customerservice")
;; (shell "cmd-onevueapi")
;; (shell "cmd-rails")
;; (shell "backend")
;; (shell "frontend")

(provide 'agg-mbp-specific)
