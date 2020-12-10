(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(css-indent-offset 2)
 '(json-reformat:indent-width 2)
 '(magit-display-buffer-function (quote magit-display-buffer-fullframe-status-v1))
 '(magit-repolist-columns
   (quote
    (("Name" 40 magit-repolist-column-ident nil)
     ("Path" 99 magit-repolist-column-path))))
 '(magit-repository-directories
   (quote
    (("~/work/wastewitness" . 0)
     ("~/.emacs.d" . 0)
     ("~/stow" . 0))))
 '(magit-status-sections-hook
   (quote
    (magit-insert-status-headers magit-insert-merge-log magit-insert-rebase-sequence magit-insert-am-sequence magit-insert-sequencer-sequence magit-insert-bisect-output magit-insert-bisect-rest magit-insert-unpulled-from-upstream magit-insert-unpulled-from-pushremote magit-insert-unpushed-to-upstream magit-insert-unpushed-to-pushremote magit-insert-staged-changes magit-insert-unstaged-changes magit-insert-untracked-files magit-insert-stashes)))
 '(org-return-follows-link t)
 '(package-selected-packages
   (quote
    (feature-mode rubocop mu4e react-snippets js-mode vue-mode coffee-mode haml-mode eslint-fix tern-auto-complete tern flymake-puppet org-preview-html mustache-mode flx-ido rvm auto-complete-nxml fuzzy ac-cider ac-html ac-inf-ruby ac-js2 ac-emacs-eclim markdown-preview-eww auto-complete unfill chruby puppet-mode magit-filenotify magit-find-file tidy smex yaml erc-hipchatify ido-vertical-mode ido-mode yari aggressive-indent html-mode bar-cursor)))
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
