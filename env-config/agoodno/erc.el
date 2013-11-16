(setq erc-autojoin-channels-alist '(("wicourts.gov" "#ccap3" "#ccap3design")))

(setq erc-email-userid "andrew.goodnough@wicourts.gov")

(erc :server "irc.wicourts.gov" :port 6667 :nick "agoodno")

(setq erc-keywords '(".*agoodno.*" "^codecommit.*$"))
