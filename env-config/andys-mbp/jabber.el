

;; ("agoodno@gmail.com"
;;       (:password . "pbtoqgfyqnfwdpvr")
;;       (:network-server . "talk.google.com")
;;       (:port . 5223)
;;       (:connection-type . ssl))


;; HipChat
 
;; (setq ssl-program-name "gnutls-cli"
;;       ssl-program-arguments '("--insecure" "-p" service host)
;;       ssl-certificate-verification-policy 1)
 
;; Connect using jabber.el
;; M-x jabber-connect <RET>
 
;; Config
;(setq jabber-account-list '(("121431_940130@chat.hipchat.com")))
(setq jabber-account-list
      '(("121431_940130@chat.hipchat.com"
         (:password . "uoPrmCThCwdzs4iu")
         (:network-server . "chat.hipchat.com")
         (:port . 5223)
         (:connection-type . ssl))))


(defvar hipchat-number "121431")
(defvar hipchat-nickname "Andy Goodnough")
 
;; Join a room
(defun hipchat-join (room)
  (interactive "sRoom name: ")
  (jabber-groupchat-join
   (jabber-read-account)
   (concat hipchat-number "_" room "@conf.hipchat.com")
   hipchat-nickname
   t))
 
;; Mention nicknames in a way that HipChat clients will pickup
(defun hipchat-mention (nickname)
  (interactive
   (list (jabber-muc-read-nickname jabber-group "Nickname: ")))
  (insert (concat "@\"" nickname "\" ")))

