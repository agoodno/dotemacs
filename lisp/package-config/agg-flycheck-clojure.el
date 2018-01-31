(use-package flycheck-clojure
  :ensure t
  :defer t
  :init (eval-after-load 'flycheck '(flycheck-clojure-setup)))

(provide 'agg-flycheck-clojure)
