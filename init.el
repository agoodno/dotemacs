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

;; adds lisp root and config directories to load-path
(add-to-list 'load-path lisp-dir)
(let ((default-directory lisp-dir))
  (normal-top-level-add-to-load-path '("package-config" "env-config")))

(defconst system-desc
  (cond
   ((string-equal system-type "darwin") "mac")
   ((string-equal system-type "gnu/linux") "linux")
   ((string-equal system-type "windows-nt") "windows")))

;; environment customizations here (user-specific, system-specific or host-specific)
(setq package-config-dir (concat lisp-dir (file-name-as-directory "package-config"))
      non-elpa-dir (concat lisp-dir (file-name-as-directory "non-elpa"))
      env-config-dir (concat lisp-dir (file-name-as-directory "env-config"))
      system-file (concat env-config-dir system-desc ".el")
      user-file (concat env-config-dir user-login-name ".el")
      host-file (concat env-config-dir system-name ".el"))

;; sets location of Customize file
(setq custom-file (concat lisp-dir "agg-custom.el"))
(load custom-file)

;; environment-specific config
(progn
  (when (file-exists-p user-file)
    (load user-file))
  (when (file-exists-p system-file)
    (load system-file))
  (when (file-exists-p host-file)
    (load host-file)))

;; -OR- Manual load like below if dynamic loading above causing problems
;;(load (concat env-config-dir "agoodno.el"))
;;(load (concat env-config-dir "linux.el"))
;;(load (concat env-config-dir "agoodno-ThinkCentre-M910t.el"))

(org-babel-load-file (expand-file-name "~/.emacs.d/agginit.org"))

(server-start)
