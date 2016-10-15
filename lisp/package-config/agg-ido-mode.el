;; Distributed with GNU Emacs

(setq ido-enable-flex-matching t)

;; Jump to a definition in the current file. (This is awesome.)
;; (global-set-key (kbd "C-x C-i") 'ido-imenu)

;; File finding
;; (global-set-key (kbd "C-x M-f") 'ido-find-file-other-window)
(global-set-key (kbd "C-x f") 'recentf-ido-find-file)

(ido-mode t)

(provide 'agg-ido-mode)
