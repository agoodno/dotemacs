;; Distributed with GNU Emacs

(add-hook 'java-mode-hook (lambda ()
                            (setq c-basic-offset 4
                                  tab-width 4)))

(provide 'agg-java-mode)
