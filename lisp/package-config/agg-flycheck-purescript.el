(use-package flycheck-purescript
  :ensure t
  :defer t)

;; this errors out and you have to kill Emacs by pid
;; so it's best not to load this at all in agg-env.el
;;  :init (eval-after-load 'flycheck '(flycheck-purescript-setup)))

(provide 'agg-flycheck-purescript)
