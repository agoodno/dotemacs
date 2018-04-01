;; The eclim install completed successfully.
;; You can now start the eclimd server by executing the script:
;;   /Applications/Eclipse.app/Contents/Eclipse/eclimd

;; For more information please see the eclimd server documentation:
;;   http://eclim.org/eclimd.html
;; For information on using eclim, please visit the getting started guide:
;;   http://eclim.org/gettingstarted.html

(use-package eclim
  :ensure t
  :defer t
  :init
  (setq eclim-auto-save t)
  (setq eclimd-autostart t)
  (setq eclim-eclipse-dirs '("/Applications/Eclipse.app"))
  (setq eclim-executable "/Applications/Eclipse.app/Contents/Eclipse/plugins/org.eclim_2.7.2/bin/eclim")
  (setq eclimd-default-workspace "/Users/andrew/eclipse-workspace")
  (setq help-at-pt-display-when-idle t)
  (setq help-at-pt-timer-delay 0.1)
  (add-hook 'json-mode-hook '(lambda () (eclim-mode t)))
                               
  :config
  (help-at-pt-set-timer)
  (global-eclim-mode))

  ;;(ac-config-default)

;; configures company
;; (require 'company)
;; (require 'company-emacs-eclim)
;; (company-emacs-eclim-setup)
;; (global-company-mode t)

(provide 'agg-eclim)
