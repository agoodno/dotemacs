;;; Ruby
;;; This file is part of the Emacs Dev Kit

;; Rake files are ruby, too, as are gemspecs, rackup files, and gemfiles.
(add-to-list 'auto-mode-alist '("\\.gemspec$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.ru$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Capfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))

;; ;; We never want to edit Rubinius bytecode
;; (add-to-list 'completion-ignored-extensions ".rbc")

;; (autoload 'run-ruby "inf-ruby"
;;   "Run an inferior Ruby process")
;; (autoload 'inf-ruby-keys "inf-ruby"
;;   "Set local key defs for inf-ruby in ruby-mode")

;; ;; yari provides a nice Emacs interface to ri
;; (require 'yari)

;; (require 'ruby-block)
;; (require 'ruby-end)

;; (add-hook 'ruby-mode-hook
;;           '(lambda ()
;;              (coding-hook)
;;              (inf-ruby-keys)
;;              ;; turn off the annoying input echo in irb
;;              (setq comint-process-echoes t)
;;              (ruby-block-mode t)
;;              (local-set-key (kbd "C-h r") 'yari)))

;; ;; HAML and SASS are quite handy in Rails development
;; (require 'haml-mode)
;; (require 'scss-mode)

;; ;; cucumber support
;; (require 'feature-mode)
;; (add-to-list 'auto-mode-alist '("\.feature$" . feature-mode))

;; ;; load bundle snippets
;; (yas/load-directory (concat ext-dir "feature-mode/snippets"))

;; (provide 'ruby-config)
