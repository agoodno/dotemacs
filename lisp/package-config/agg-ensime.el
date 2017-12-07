(use-package ensime
  :ensure t
  :defer t
  :pin melpa-stable)

(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)

(setq
  ensime-sbt-command "/home/agoodno/src/ccap3/sbt"
  sbt:program-name "/home/agoodno/src/ccap3/sbt"
  ensime-startup-notification nil)

(provide 'agg-ensime)
