;; Distributed with GNU Emacs

;; Open links in Chrome on macOS
;; (setq gnus-button-url 'browse-url-generic
;;       browse-url-generic-program "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
;;       browse-url-browser-function gnus-button-url)

;; Open links in Safari
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "open")

(provide 'agg-browse-url)
