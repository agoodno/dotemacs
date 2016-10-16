;; Distributed with GNU Emacs

(load "~/.ercpass")

(defvar freenode-password freenode-agoodno-pass)
(defvar bitlbee-password bitlbee-agoodno-pass)

(add-hook 'erc-join-hook 'bitlbee-identify)

(defun bitlbee-identify ()
  "If we're on the bitlbee server, send the identify command to the &bitlbee channel."
  (when (and (string= "127.0.0.1" erc-session-server)
             (string= "&bitlbee" (buffer-name)))
    (erc-message "PRIVMSG" (format "%s identify %s"
                                   (erc-default-target)
                                   bitlbee-password))))

(setq
  erc-prompt-for-nickserv-password nil
  erc-nickserv-passwords `((freenode ("agoodno" . ,freenode-password)))
  erc-server "irc.freenode.net"
  erc-nick "agoodno"
  erc-email-userid "agoodno@gmail.com"
  erc-user-full-name "Andrew Goodnough"
  erc-autojoin-channels-alist '((".*freenode.*" "#emacs" "#elasticsearch"))
  erc-echo-notices-in-minibuffer-flag t
  erc-auto-query 'buffer
  erc-save-buffer-on-part nil
  erc-save-queries-on-quit nil
  erc-log-write-after-send t
  erc-log-write-after-insert t
  erc-prompt (lambda () (concat "[" (buffer-name) "]")))

(require 'erc-services)
(erc-services-mode 1)

;; ;;; Notify me when a keyword is matched (someone wants to reach me)

;; (defvar my-erc-page-message "%s says %s"
;;   "Format of message to display in dialog box")

;; (defvar my-erc-page-nick-alist nil
;;   "Alist of nicks and the last time they tried to trigger a notification")

;; (defvar my-erc-page-timeout 60
;;   "Number of seconds that must elapse between notifications from the same person.")

;; (defun my-erc-page-popup-notification (message)
;;   (when window-system
;;     ;; must set default directory, otherwise start-process is unhappy
;;     ;; when this is something remote or nonexistent
;;     (let ((default-directory "~/"))
;;       ;; 8640000 milliseconds = 1 day
;;       (start-process "page-me" nil "notify-send"
;;                      "-u" "normal" "-t" "8640000" "ERC"
;;                      (format my-erc-page-message (car (split-string nick "!")) message)))))

;; (defun my-erc-page-allowed (nick &optional delay)
;;   "Return non-nil if a notification should be made for NICK.
;; If DELAY is specified, it will be the minimum time in seconds
;; that can occur between two notifications.  The default is
;; `my-erc-page-timeout'."
;;   (unless delay (setq delay my-erc-page-timeout))
;;   (let ((cur-time (time-to-seconds (current-time)))
;;         (cur-assoc (assoc nick my-erc-page-nick-alist))
;;         (last-time))
;;     (if cur-assoc
;;         (progn
;;           (setq last-time (cdr cur-assoc))
;;           (setcdr cur-assoc cur-time)
;;           (> (abs (- cur-time last-time)) delay))
;;       (push (cons nick cur-time) my-erc-page-nick-alist)
;;       t)))

;; (defun my-erc-page-me (match-type nick message)
;;   "Notify the current user when someone sends a message that
;; matches a regexp in `erc-keywords'."
;;   (interactive)
;;   (when (and (eq match-type 'keyword)
;;              ;; I don't want to see anything from the erc server
;;              (null (string-match "\\`\\([sS]erver\\|localhost\\)" nick))
;;              ;; or bots
;;              (null (string-match "\\(bot\\|serv\\)!" nick))
;;              ;; or from those who abuse the system
;;              (my-erc-page-allowed nick))
;;     (my-erc-page-popup-notification message)))
;; (add-hook 'erc-text-matched-hook 'my-erc-page-me)

;; (defun my-erc-page-me-PRIVMSG (proc parsed)
;;   (let ((nick (car (erc-parse-user (erc-response.sender parsed))))
;;         (target (car (erc-response.command-args parsed)))
;;         (msg (erc-response.contents parsed)))
;;     (when (and (erc-current-nick-p target)
;;                (not (erc-is-message-ctcp-and-not-action-p msg))
;;                (my-erc-page-allowed nick))
;;       (my-erc-page-popup-notification msg)
;;       nil)))
;; (add-hook 'erc-server-PRIVMSG-functions 'my-erc-page-me-PRIVMSG)

;; (eval-after-init
;;  '(and
;;                                         ; (add-to-list 'erc-modules 'autoaway)
;;    (add-to-list 'erc-modules 'autojoin)
;;    (add-to-list 'erc-modules 'button)
;;    (add-to-list 'erc-modules 'completion)
;;    (add-to-list 'erc-modules 'fill)
;;    (add-to-list 'erc-modules 'irccontrols)
;;    (add-to-list 'erc-modules 'list)
;;    (add-to-list 'erc-modules 'log)
;;    (add-to-list 'erc-modules 'match)
;;    (add-to-list 'erc-modules 'menu)
;;    (add-to-list 'erc-modules 'move-to-prompt)
;;    (add-to-list 'erc-modules 'netsplit)
;;    (add-to-list 'erc-modules 'networks)
;;    (add-to-list 'erc-modules 'noncommands)
;;    (add-to-list 'erc-modules 'notify)
;;    (add-to-list 'erc-modules 'readonly)
;;    (add-to-list 'erc-modules 'ring)
;;    (add-to-list 'erc-modules 'stamp)
;;    (add-to-list 'erc-modules 'track )
;;    (erc-update-modules)))

;; (customize-set-variable 'erc-server "irc.freenode.net")
;; (customize-set-variable 'erc-port 6667)
;; (customize-set-variable 'erc-nick "agoodno")



(defun freenode-connect ()
  "Connect to freenode."
  (interactive)
  (erc :server "irc.freenode.net" :port 6667 :nick "agoodno"))

(defun bitlbee-connect ()
  "Connect to bitlbee."
  (interactive)
  (erc :server "127.0.0.1" :port 6667))

(provide 'agg-erc)
