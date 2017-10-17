(use-package flycheck-clojure
  :ensure t
  :init (eval-after-load 'flycheck '(flycheck-clojure-setup)))

(provide 'agg-flycheck-clojure)
