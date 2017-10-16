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

;; loads my configuration

;; each of these files must end with a provide statement that creates
;; a symbol that this script can reference
;;   ex. (provide 'agg-bindings)

;; general config
(require 'agg-misc)
(require 'agg-look-and-feel-sound-and-color)
(require 'agg-defun)
(require 'agg-binding)

;; environment config
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

(server-start)
