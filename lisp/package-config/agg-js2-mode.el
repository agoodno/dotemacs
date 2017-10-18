(use-package js2-mode
  :ensure t
  :defer t)

;; http://elpa.gnu.org/packages/js2-mode.html

;; To install it as your major mode for JavaScript editing:
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

;; You may also want to hook it in for shell scripts running via node.js:
(add-to-list 'interpreter-mode-alist '("node" . js2-mode))

;; Support for JSX is available via the derived mode `js2-jsx-mode'.  If you
;; also want JSX support, use that mode instead:
(add-to-list 'auto-mode-alist '("\\.jsx?\\'" . js2-jsx-mode))
(add-to-list 'interpreter-mode-alist '("node" . js2-jsx-mode))

(customize-set-variable 'js2-basic-offset 2)
(customize-set-variable 'js2-bounce-indent-p t)

;(add-hook 'js2-mode-hook (lambda () (setq js2-basic-offset 2)))

(provide 'agg-js2-mode)
