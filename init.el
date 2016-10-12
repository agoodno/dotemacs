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
(require 'agg-defun)
(require 'agg-binding)
(require 'agg-mac-specific)
(require 'agg-mbp-specific)
(require 'agg-color-theme-dark)
;;(require 'agg-color-theme-light)

;; packages
(require 'agg-bar-cursor)
(require 'agg-enh-ruby-mode)
(require 'agg-html-mode)
(require 'agg-markdown-mode)
(require 'agg-restclient)
;; (require 'agg-ruby-mode)
(require 'agg-json-mode)
(require 'agg-org-mode)
(require 'agg-saveplace)
(require 'agg-scala-mode)
(require 'agg-shell-mode)
(require 'agg-sql-mode)
(require 'agg-uniquify)

(server-start)
