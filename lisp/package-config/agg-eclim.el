(use-package eclim
  :ensure t
  :defer t)
;;  :init (setq eclim-eclipse-dirs '("~/opt/eclipse"))
;;        (setq eclim-executable "~/opt/eclipse/eclim"))

(require 'eclim)
(global-eclim-mode)

;; (require 'eclim)
;; ;(require 'eclimd)

(setq eclim-auto-save t)

;;(setenv "STATIC_JARS" "/home/agoodno/workspace/StaticJars/")

;; ;; display compilation error messages in the echo area
(setq help-at-pt-display-when-idle t)
(setq help-at-pt-timer-delay 0.1)
(help-at-pt-set-timer)

;; configures company
(require 'company)
(require 'company-emacs-eclim)
(company-emacs-eclim-setup)
(global-company-mode t)

;; ;; find the daemon
;; (setq eclim-executable "/home/andrew/opt/eclipse-standard-kepler-SR1-linux-gtk-x86_64/plugins/org.eclim_2.3.2/bin/eclim")

(provide 'agg-eclim)
