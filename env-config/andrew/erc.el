(setq erc-nickserv-alist '(("irc.freenode.net")))

(load "~/.ercpass")
(require 'erc-services)

(erc-services-mode 1)

(setq erc-prompt-for-nickserv-password nil)

(setq erc-nickserv-passwords `((freenode (("agoodno" . , freenode-agoodno-pass)))))

(setq erc-autojoin-channels-alist '(("freenode.net" "#emacs")))

(setq erc-email-userid "agoodno@gmail.com")

(setq erc-keywords '(".*agoodno.*"))
