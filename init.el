;; "Emacs outshines all other editing software in approximately the
;; same way that the noonday sun does the stars. It is not just bigger
;; and brighter; it simply makes everything else vanish."
;; -Neal Stephenson, "In the Beginning was the Command Line"

(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar my-packages '(ack bar-cursor bitlbee blank-mode ensime erc erc-hl-nicks
                          ercn ido js2-mode magit org paredit
                          scala-mode2 yasnippet)
  "A list of packages to ensure are installed at launch.")

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

;; turn off mouse interface early in startup to avoid momentary display
(dolist (mode '(menu-bar-mode tool-bar-mode scroll-bar-mode))
  (when (fboundp mode) (funcall mode -1)))

;; set variable to the .emacs.d directory
(setq dotfiles-dir (file-name-directory
                    (or (buffer-file-name) load-file-name)))

;; adds .emacs.d directory to the load path
(add-to-list 'load-path dotfiles-dir)

(string-match "^\\([^\\.]+\\)\\(\\.\\(.*\\)\\)?$" (system-name))
(defconst host-name (replace-match "\\1" t nil (system-name))
  "Host part of function `system-name'.")

(defconst system-desc
  (cond
   ((string-equal system-type "darwin") "mac")
   ((string-equal system-type "gnu/linux") "linux")
   ((string-equal system-type "windows-nt") "windows")))

;; environment customizations here (user-specific, system-specific or host-specific)
(setq package-config-dir (concat dotfiles-dir "package-config/")
      env-config-dir (concat dotfiles-dir "env-config/")
      system-file (concat env-config-dir system-desc ".el")
      system-dir (concat env-config-dir system-desc)
      user-file (concat env-config-dir user-login-name ".el")
      user-dir (concat env-config-dir user-login-name)
      host-file (concat env-config-dir host-name ".el")
      host-dir (concat env-config-dir host-name))

;; loads agg customizations
(require 'agg-misc)
(require 'agg-bindings)
(require 'agg-defuns)

(progn
  (when (file-exists-p package-config-dir)
    (mapc 'load (directory-files package-config-dir t "^[^#].*el$")))
  (when (file-exists-p user-file)
    (load user-file))
  (when (file-exists-p user-dir)
    (mapc 'load (directory-files user-dir t "^[^#].*el$")))
  (when (file-exists-p system-file)
    (load system-file))
  (when (file-exists-p system-dir)
    (mapc 'load (directory-files system-dir t "^[^#].*el$")))
  (when (file-exists-p host-file)
    (load host-file))
  (when (file-exists-p host-dir)
    (mapc 'load (directory-files host-dir t "^[^#].*el$"))))

(eval-after-load 'magit
  '(progn
     (set-face-foreground 'magit-diff-add "green4")
     (set-face-foreground 'magit-diff-del "red3")
     (set-face-background 'magit-item-highlight "#000000")
     (set-face-background 'diff-file-header "#000000")
     (set-face-foreground 'diff-context "#777777")
     (set-face-background 'diff-added "#000000")
     (set-face-background 'diff-removed "#000000")))

;(server-start)
