(use-package markdown-mode
  :ensure t
  :defer t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "/usr/local/bin/markdown"))

;; Every time I save the markdown file, I want to export it to an HTML file for viewing.
;;
;; This re-binds the normal 'save-buffer' key-chord to call
;; 'markdown-export'. It works because 'markdown-export' calls
;; 'save-buffer' in addition to exporting to HTML.
;; (eval-after-load 'markdown
;;   '(progn
;;      (define-key markdown-mode-map (kbd "C-x C-s") 'markdown-export)))

;;(define-key markdown-mode-map (kbd "C-x C-s") 'markdown-export)
(provide 'agg-markdown-mode)
