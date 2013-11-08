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

(defvar my-packages '(ack bar-cursor bitlbee erc erc-hl-nicks ensime ido js2-mode magit org paredit
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

;; sdds .emacs.d directory to the load path
(add-to-list 'load-path dotfiles-dir)

;; You can keep system- or user-specific customizations here
(string-match "^\\([^\\.]+\\)\\(\\.\\(.*\\)\\)?$" (system-name))
(defconst host-name (replace-match "\\1" t nil (system-name))
  "Host part of function `system-name'.")

(setq agg-system-config (concat dotfiles-dir host-name ".el")
      agg-user-config (concat dotfiles-dir user-login-name ".el")
      agg-system-dir (concat dotfiles-dir host-name)
      agg-user-dir (concat dotfiles-dir user-login-name))

(defun eval-after-init (form)
  "Add `(lambda () FORM)' to `after-init-hook'.

If Emacs has already finished initialization, also eval FORM immediately."
  (let ((func (list 'lambda nil form)))
    (add-hook 'after-init-hook func)
    (when after-init-time
      (eval form))))

(eval-after-init
 '(progn
    (when (file-exists-p agg-system-config) (load agg-system-config))
    (when (file-exists-p agg-user-config) (load agg-user-config))
    (when (file-exists-p agg-system-dir)
      (mapc 'load (directory-files agg-system-dir t "^[^#].*el$")))
    (when (file-exists-p agg-user-dir)
      (mapc 'load (directory-files agg-user-dir t "^[^#].*el$")))))

(eval-after-load 'magit
  '(progn
     (set-face-foreground 'magit-diff-add "green4")
     (set-face-foreground 'magit-diff-del "red3")))

;; loads agg customizations
(require 'agg-misc)
(require 'agg-bindings)

(server-start)
