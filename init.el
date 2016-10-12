;; "Emacs outshines all other editing software in approximately the
;; same way that the noonday sun does the stars. It is not just bigger
;; and brighter; it simply makes everything else vanish."
;; -Neal Stephenson, "In the Beginning was the Command Line"

(require 'package)
;(add-to-list 'package-archives
;             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar my-packages '(ack bar-cursor bitlbee coffee-mode enh-ruby-mode erc
                      erc-hl-nicks ercn ido js2-mode magit org paredit
                      ruby-mode rinari sbt-mode scala-mode2)
  "A list of packages to ensure are installed at launch.")

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

(setq exec-path (append "/usr/local/bin" exec-path))

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
      non-elpa-dir (concat dotfiles-dir "non-elpa/")
      env-config-dir (concat dotfiles-dir "env-config/")
      system-file (concat env-config-dir system-desc ".el")
      system-dir (concat env-config-dir system-desc)
      user-file (concat env-config-dir user-login-name ".el")
      user-dir (concat env-config-dir user-login-name)
      host-file (concat env-config-dir host-name ".el")
      host-dir (concat env-config-dir host-name)
      custom-file (concat dotfiles-dir "custom.el"))

;; loads agg customizations
(require 'agg-misc)
(require 'agg-bindings)
(require 'agg-defuns)

(progn
  (when (file-exists-p user-dir)
    (mapc 'load (directory-files user-dir t "^[^#].*el$")))
  (when (file-exists-p system-dir)
    (mapc 'load (directory-files system-dir t "^[^#].*el$")))
  (when (file-exists-p host-dir)
    (mapc 'load (directory-files host-dir t "^[^#].*el$")))
  (when (file-exists-p user-file)
    (load user-file))
  (when (file-exists-p system-file)
    (load system-file))
  (when (file-exists-p host-file)
    (load host-file))
  (when (file-exists-p custom-file)
    (load custom-file)))

(eval-after-load 'erc
  '(progn
     (load (concat package-config-dir "erc.el"))
     (when (file-exists-p (concat user-dir "erc.el"))
       (load (concat user-dir "erc.el")))
     (when (file-exists-p (concat system-dir "erc.el"))
       (load (concat system-dir "erc.el")))
     (when (file-exists-p (concat host-dir "erc.el"))
       (load (concat host-dir "erc.el")))))

(eval-after-load 'jabber
  '(progn
     (load (concat package-config-dir "jabber.el"))
     (when (file-exists-p (concat user-dir "jabber.el"))
       (load (concat user-dir "jabber.el")))
     (when (file-exists-p (concat system-dir "jabber.el"))
       (load (concat system-dir "jabber.el")))
     (when (file-exists-p (concat host-dir "jabber.el"))
       (load (concat host-dir "jabber.el")))))

(eval-after-load 'jabber-hipchat
  '(progn
     (load (concat package-config-dir "jabber-hipchat.el"))
     (when (file-exists-p (concat user-dir "jabber-hipchat.el"))
       (load (concat user-dir "jabber-hipchat.el")))
     (when (file-exists-p (concat system-dir "jabber-hipchat.el"))
       (load (concat system-dir "jabber-hipchat.el")))
     (when (file-exists-p (concat host-dir "jabber-hipchat.el"))
       (load (concat host-dir "jabber-hipchat.el")))))

(load (concat package-config-dir "enh-ruby-mode.el"))
(load (concat package-config-dir "markdown-mode.el"))

(load (concat non-elpa-dir "autotest.el"))

;(require 'yasnippet)
;(yas-global-mode nil)

(add-hook 'enh-ruby-mode-hook (rinari-minor-mode t))

(server-start)
