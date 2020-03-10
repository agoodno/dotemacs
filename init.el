;; "Emacs outshines all other editing software in approximately the
;; same way that the noonday sun does the stars. It is not just bigger
;; and brighter; it simply makes everything else vanish."
;; -Neal Stephenson, "In the Beginning was the Command Line"

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
;; (add-to-list 'package-archives
;;              '("melpa2" . "http://www.mirrorservice.org/sites/melpa.org/packages/"))
;; (add-to-list 'package-archives
;;              '("melpa3" . "http://www.mirrorservice.org/sites/stable.melpa.org/packages/"))
;; (add-to-list 'package-archives
;;              '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

(setq load-prefer-newer t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-return-follows-link t)
 '(package-selected-packages
   (quote
    (rubocop mu4e react-snippets js-mode vue-mode coffee-mode haml-mode eslint-fix tern-auto-complete tern flymake-puppet org-preview-html mustache-mode flx-ido rvm auto-complete-nxml fuzzy ac-cider ac-html ac-inf-ruby ac-js2 ac-emacs-eclim markdown-preview-eww auto-complete unfill chruby puppet-mode magit-filenotify magit-find-file tidy smex yaml erc-hipchatify ido-vertical-mode ido-mode yari aggressive-indent html-mode bar-cursor)))
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

;; load my configuration
(org-babel-load-file (expand-file-name "~/.emacs.d/agginit.org"))

(server-start)
