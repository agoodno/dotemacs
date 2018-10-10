;; "Emacs outshines all other editing software in approximately the
;; same way that the noonday sun does the stars. It is not just bigger
;; and brighter; it simply makes everything else vanish."
;; -Neal Stephenson, "In the Beginning was the Command Line"

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
;; (add-to-list 'package-archives
;;              '("melpa2" . "http://www.mirrorservice.org/sites/melpa.org/packages/"))
;; (add-to-list 'package-archives
;;              '("melpa3" . "http://www.mirrorservice.org/sites/stable.melpa.org/packages/"))
;; (add-to-list 'package-archives
;;              '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(use-package auto-compile
  :config (auto-compile-on-load-mode))
(setq load-prefer-newer t)

;; set variable to the .emacs.d directory
(setq lisp-dir (concat
                (file-name-directory (or (buffer-file-name) load-file-name))
                (file-name-as-directory "lisp")))

;; adds lisp root to load-path
(add-to-list 'load-path lisp-dir)

;; sets location of Customize file
(setq custom-file (concat lisp-dir "agg-custom.el"))
(load custom-file)

;; load my configuration
(org-babel-load-file (expand-file-name "~/.emacs.d/agginit.org"))

(server-start)
