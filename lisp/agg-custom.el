;; This should mostly do nothing but some things I can't get to work
;; any other way so it's here if I need it and included by default

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-return-follows-link t)
 '(package-selected-packages
   (quote
    (smartparens neotree flx-ido rvm robe exec-path-from-shell auto-complete-nxml fuzzy ac-cider ac-html ac-inf-ruby ac-js2 ac-emacs-eclim eclim markdown-preview-eww auto-complete unfill yaml-mode restclient markdown-mode chruby puppet-mode magit-filenotify magit-find-file tidy smex projectile ido-completing-read+ flycheck-clojure flycheck cider yaml clojure-mode f erc-hipchatify js2-mode ido-vertical-mode ido-mode bundler yari magit aggressive-indent html-mode json-mode enh-ruby-mode bar-cursor auto-compile)))
 '(safe-local-variable-values
   (quote
    ((scala-indent:use-javadoc-style . t)
     (js2-bounce-indent-p . t)
     (java-indent-level . 4)
     (groovy-indent-offset . 2)
     (css-indent-offset . 2)
     (js-switch-indent-offset . 2)
     (js-indent-level . 2))))
 '(send-mail-function (quote smtpmail-send-it)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(provide 'agg-custom)
