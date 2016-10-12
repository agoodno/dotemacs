(use-package scala-mode
  :ensure t
  :defer t
  :init (add-to-list 'auto-mode-alist '("\\.sbt$" . scala-mode))
    (add-hook 'scala-mode-hook 'progmodes-hooks))

;; This step causes the ensime-mode to be started whenever
;; scala-mode is started for a buffer. You may have to customize this step
;; if you're not using the standard scala mode.
;(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)

;; MINI HOWTO:
;; Open .scala file. M-x ensime (once per project)
;; end ENSIME

(provide 'agg-scala-mode)
