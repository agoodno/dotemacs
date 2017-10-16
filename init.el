;; "Emacs outshines all other editing software in approximately the
;; same way that the noonday sun does the stars. It is not just bigger
;; and brighter; it simply makes everything else vanish."
;; -Neal Stephenson, "In the Beginning was the Command Line"

(require 'package)

(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(setq use-package-verbose t)
(setq use-package-always-ensure t)
(require 'use-package)
(use-package auto-compile
  :config (auto-compile-on-load-mode))
(setq load-prefer-newer t)

;; adds root and config directories to load-path
(add-to-list 'load-path "~/.emacs.d/lisp")
(let ((default-directory  "~/.emacs.d/lisp/"))
  (normal-top-level-add-to-load-path '("package-config" "env-config")))

;; sets location of Customize file
(setq custom-file "~/.emacs.d/lisp/agg-custom.el")
(load custom-file)

;; loads my configuration

;; each of these files must end with a provide statement that creates
;; a symbol that this script can reference
;;   ex. (provide 'agg-bindings)

;; misc config
(require 'agg-misc)
(require 'agg-look-and-feel-sound-and-color)
(require 'agg-defun)
(require 'agg-binding)

;; environment config
(require 'agg-mac-specific)
(require 'agg-mbp-specific)
(require 'agg-color-theme-dark)
;;(require 'agg-color-theme-light)

;; package config
(require 'agg-aggressive-indent)
(require 'agg-auto-complete)
;; (require 'agg-ac-emacs-eclim)
(require 'agg-bar-cursor)
(require 'agg-bundler)
(require 'browse-url)
(require 'agg-chruby)
(require 'agg-cider)
(require 'agg-clojure-mode)
;; (require 'agg-company-emacs-eclim)
(require 'agg-company)
;; (require 'agg-eclim)
;; (require 'agg-ensime)
;; (require 'agg-erc)
;;(require 'agg-erc-hipchatify)
(require 'agg-html-mode)
(require 'agg-ido-mode)
(require 'agg-ido-vertical-mode)
(require 'agg-js2-mode)
(require 'agg-json-mode)
(require 'agg-json-reformat)
(require 'agg-markdown-mode)
;(require 'agg-markdown-preview-eww)
(require 'agg-magit)
(require 'agg-nxml-mode)
(require 'agg-org-mode)
(require 'agg-restclient)
(require 'agg-ruby-mode)
(require 'agg-robe)
;;(require 'agg-saveplace)
(require 'agg-sbt-mode)
(require 'agg-scala-mode)
(require 'agg-shell-mode)
(require 'agg-sql-mode)
(require 'agg-uniquify)
(require 'agg-yaml-mode)
(require 'agg-yari)

(server-start)
