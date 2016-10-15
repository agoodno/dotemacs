(use-package magit
  :ensure t
  :init
  (customize-set-variable 'magit-display-buffer-function
    (quote magit-display-buffer-fullframe-status-v1))
  (customize-set-variable 'magit-status-sections-hook
    '(magit-insert-status-headers
      magit-insert-merge-log
      magit-insert-rebase-sequence
      magit-insert-am-sequence
      magit-insert-sequencer-sequence
      magit-insert-bisect-output
      magit-insert-bisect-rest
      magit-insert-bisect-log
      magit-insert-unpulled-from-upstream
      magit-insert-unpulled-from-pushremote
      magit-insert-unpushed-to-upstream
      magit-insert-unpushed-to-pushremote
      magit-insert-staged-changes
      magit-insert-unstaged-changes
      magit-insert-untracked-files
      magit-insert-stashes))
  (customize-set-variable 'magit-repolist-columns
    (quote
      (("Name" 40 magit-repolist-column-ident nil)
      ("Path" 99 magit-repolist-column-path))))
  (customize-set-variable 'magit-repository-directories
    (quote
      (("~/.emacs.d" . 0)
      ("~/src/customerservice" . 0)
      ("~/src/deviceapi" . 0)
      ("~/src/mar-accountalertsettingcreator" . 0)
      ("~/src/mar-alert-measurement-updater" . 0)
      ("~/src/mar-alert-rule-deleter" . 0)
      ("~/src/mar-alert-rule-updater" . 0)
      ("~/src/mar-alert-service-client" . 0)
      ("~/src/mar-alertservice" . 0)
      ("~/src/mar-api" . 0)
      ("~/src/mar-firmwareservice" . 0)
      ("~/src/mar-forecast-service" . 0)
      ("~/src/mar-forecast-service-client" . 0)
      ("~/src/mar-hub-chart-export-sender" . 0)
      ("~/src/mar-hubapi" . 0)
      ("~/src/mar-ios" . 0)
      ("~/src/mar-system-alert-creator" . 0)
      ("~/src/mar-systemrulecreator" . 0)
      ("~/src/mar-valuealertprocessor" . 0)
      ("~/src/mar-webui" . 0)
      ("~/src/onevueapi" . 0)
      ("~/src/ov-clockstatusesprocessor" . 0)
      ("~/src/ov-probereadingsprocessor" . 0)
      ("~/src/ov-readings-stream" . 0)
      ("~/src/ov-readingsprocessor" . 0)
      ("~/src/ov-twilioprocessor" . 0)
      ("~/src/ov-utilities" . 0)
      ("~/src/queue-processor" . 0)
      ("~/src/rails" . 0)))))

(provide 'agg-magit)
