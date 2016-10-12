;; Rake files are ruby, too, as are gemspecs, rackup files, and gemfiles.
(add-to-list 'auto-mode-alist '("\\.gemspec$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rake$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\.ru$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("Capfile$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile$" . enh-ruby-mode))

;; ;; We never want to edit Rubinius bytecode
;; (add-to-list 'completion-ignored-extensions ".rbc")

;; (autoload 'run-ruby "inf-ruby"
;;   "Run an inferior Ruby process")
;; (autoload 'inf-ruby-keys "inf-ruby"
;;   "Set local key defs for inf-ruby in enh-ruby-mode")

;; ;; yari provides a nice Emacs interface to ri
;; (require 'yari)

;(require 'ruby-block)
;(require 'ruby-end)

;;(require 'rinari)

;;(defun turn-on-rinari () (rinari-minor-mode 1))
;;(add-hook 'enh-ruby-mode-hook 'turn-on-rinari)
(add-hook 'enh-ruby-mode-hook 'progmodes-hooks)
(add-hook 'ruby-mode-hook 'progmodes-hooks)
;          '(lambda ()
;             (coding-hook)
;             (inf-ruby-keys)
             ;; turn off the annoying input echo in irb
;             (setq comint-process-echoes t)
;             (ruby-block-mode t)
;             ))

;;             (local-set-key (kbd "C-h r") 'yari)))

;; ;; HAML and SASS are quite handy in Rails development
;; (require 'haml-mode)
;; (require 'scss-mode)

;; ;; cucumber support
;; (require 'feature-mode)
;; (add-to-list 'auto-mode-alist '("\.feature$" . feature-mode))

;; ;; load bundle snippets
;; (yas/load-directory (concat ext-dir "feature-mode/snippets"))

;; (provide 'ruby-config)

(remove-hook 'enh-ruby-mode-hook 'erm-define-faces)
