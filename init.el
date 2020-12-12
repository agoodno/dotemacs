(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
;; (add-to-list 'package-archives
;;              '("melpa2" . "http://www.mirrorservice.org/sites/melpa.org/packages/"))
;; (add-to-list 'package-archives
;;              '("melpa3" . "http://www.mirrorservice.org/sites/stable.melpa.org/packages/"))
;; (add-to-list 'package-archives
;;              '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

(setq load-prefer-newer t)

;; load secrets
(setq secrets-file (concat user-emacs-directory "secrets.el"))
(load secrets-file :noerror)

;; set custom file location
(setq custom-file (concat user-emacs-directory "custom.el"))
(load custom-file :noerror)

;; Note: *inhibit-startup-message* and *inhibit-splash-screen* are aliases for this variable
;; Turn off startup splash
(setq inhibit-startup-screen t)

;; Turn off menu
(menu-bar-mode -1)

;; Turn off tool-bar
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))

;; Turn off scroll-bar
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))

;; Turn off initial scratch buffer text message
(setq initial-scratch-message nil)

;; Disable line wrap
(setq default-truncate-lines t)

;; Highlight selected regions
(setq transient-mark-mode t)

;; Display line and column numbers
(setq line-number-mode t)
(setq column-number-mode t)

;; Prompt
(defalias 'yes-or-no-p 'y-or-n-p)

;; Change backups to go to a backup directory
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))

;; Auto revert all files changed elsewhere
(global-auto-revert-mode t)

;; Set pager to cat for shell
(setenv "PAGER" "/bin/cat")

;; Compilation buffer

;; Scroll with output automatically
(setq compilation-scroll-output t)
;;(setq compilation-scroll-output 'first-error)

;; Show on top of current buffer instead of new buffer
(add-to-list 'same-window-buffer-names "*compilation*")

(use-package exec-path-from-shell
  :ensure t
  :init
  ;;(setq shell-file-name "/usr/local/bin/zsh")
  (setq exec-path-from-shell-variables '("PATH" "MANPATH")) ;; "PKG_CONFIG_PATH" "LDFLAGS"
  :config
  (exec-path-from-shell-initialize)
  ;; Make ansi-term play nice with zsh prompt.
  (defadvice ansi-term (after advise-ansi-term-coding-system)
    (set-buffer-process-coding-system 'utf-8-unix 'utf-8-unix)))

(defun friendly-visible-bell ()
  "A friendlier visual bell effect."
  (invert-face 'mode-line)
  (run-with-timer 0.1 nil 'invert-face 'mode-line))

(setq visible-bell nil
      ring-bell-function #'friendly-visible-bell)

(use-package ansi-color
  :ensure t
  :init
  (defun my/ansi-colorize-buffer ()
    (let ((buffer-read-only nil))
      (ansi-color-apply-on-region (point-min) (point-max))))
  (add-hook 'compilation-filter-hook 'my/ansi-colorize-buffer))

(use-package dracula-theme
  :ensure t
  :defer t)

(use-package gruvbox-theme
  :ensure t
  :defer t)

(use-package spacemacs-theme
  :ensure t
  :defer t
  :init
  (setq spacemacs-theme-org-agenda-height nil)
  (setq spacemacs-theme-org-height nil))

(show-paren-mode 1)
(setq-default indent-tabs-mode nil)

;; Indent with spaces, never with TABs
(setq-default indent-tabs-mode nil)

;; Sets basic offset
(setq c-basic-offset 2)

;; Indent to 2 spaces
(setq-default tab-width 2)

;; Tabs stop every 2 spaces
(setq-default tab-stop-list (quote (2 4 6 8 10)))

(use-package aggressive-indent
  :ensure t)

(global-hl-line-mode +1)

(use-package bar-cursor
  :ensure t
  :init (bar-cursor-mode 1))

(setq x-select-enable-clipboard t
      ;; x-select-enable-primary t ;;causes problems with delete-selection-mode
      save-interprogram-paste-before-kill nil
      apropos-do-all t
      mouse-yank-at-point nil)

;; Paste and backspace operations delete the selection and "pastes over" it
(delete-selection-mode t)

;; Make side by side buffers function the same as the main window
(setq truncate-partial-width-windows nil)

(setq split-width-threshold nil)

(use-package dired-sidebar
  :bind (("C-x C-n" . dired-sidebar-toggle-sidebar))
  :ensure t
  :commands (dired-sidebar-toggle-sidebar)
  :init
  (add-hook 'dired-sidebar-mode-hook
            (lambda ()
              (unless (file-remote-p default-directory)
                (auto-revert-mode))))
  :config
  (push 'toggle-window-split dired-sidebar-toggle-hidden-commands)
  (push 'rotate-windows dired-sidebar-toggle-hidden-commands)

  (setq dired-sidebar-subtree-line-prefix "__")
  ;; (setq dired-sidebar-theme 'vscode)
  (setq dired-sidebar-use-term-integration t)
  (setq dired-sidebar-use-custom-font t))

(use-package spaceline
  :ensure t
  :init
  (setq powerline-default-separator 'arrow-fade)
  :config
  (spaceline-spacemacs-theme))

(defun untabify-buffer ()
  "Untabify current buffer"
  (interactive)
  (untabify (point-min) (point-max)))

(defun progmodes-before-save-hook ()
  "Hooks which run on file write for programming modes"
  (require 'whitespace)

  (prog1 nil
    (set-buffer-file-coding-system 'utf-8-unix)
    (untabify-buffer)
    (whitespace-cleanup)))

(defun progmodes-hooks ()
  "Hooks for programming modes"
  (add-hook 'before-save-hook 'progmodes-before-save-hook))

(defun shell-dir (name dir)
  "Opens a shell into the specified directory
 ex. (shell-dir "cmd-rails" "/Users/agoodnough/src/rails/")"
  (let ((default-directory dir))
    (shell name)))

(defun insert-current-date ()
  (interactive)
  (insert (shell-command-to-string "echo -n $(date %Y-%m-%d)")))

(require 'calendar)
(defun insdate-insert-current-date (&optional omit-day-of-week-p)
  "Insert today's date using the current locale.
  With a prefix argument, the date is inserted without the day of
  the week."
  (interactive "P*")
  (insert (calendar-date-string (calendar-current-date) nil
                                omit-day-of-week-p)))

(defun insert-date (prefix)
  "Insert the current date. With prefix-argument, use ISO format. With
   two prefix arguments, write out the day and month name."
  (interactive "P")
  (let ((format "%Y-%m-%d")
        (system-time-locale "en_US"))
    (insert (format-time-string format))))

(defun ins-tommorrows-date ()
  (interactive)
  (insert (format-time-string "%A, %B %e, %Y" (time-add (current-time) (seconds-to-time (* 60 (* 60 (* 24))))))))

;; (float-time)
;; (calendar-date-string (decode-time (seconds-to-time (+ (* 60 (* 60 (* 24))) (float-time (current-time))))))

;; (format-time-string "%A, %B %e, %Y" (decode-time (time-add (current-time) (seconds-to-time (* 60 (* 60 (* 24)))))))

;; (seconds-to-time (* 60 (* 60 (* 24))))

;; (format-time-string "%A, %B %e, %Y" (current-time))
;; (format-time-string "%A, %B %e, %Y" (time-add (current-time) (seconds-to-time (* 60 (* 60 (* 24))))))
;; (decode-time (seconds-to-time (+ (float-time (current-time)) (* 60 (* 60 (* 24))))))

(defun back-window ()
  (interactive)
  (other-window -1))

(defun log-region (&optional arg)
  "Keyboard macro."
  (interactive "p")
  (kmacro-exec-ring-item
   (quote ([134217847 16 5 return 112 117 116 115 32 34 25 61 35 123 25 125 34] 0 "%d")) arg))

(defun agg-set-background-color-dark ()
  (progn
    (load-theme 'spacemacs-dark t)

    (set-face-attribute  'mode-line-inactive
                         nil
                         :foreground "gray80"
                         :background "gray25"
                         :box '(:line-width 1 :style released-button))
    (set-face-attribute  'mode-line
                         nil
                         :foreground "gray25"
                         :background "gray80"
                         :box '(:line-width 1 :style released-button))

    (set-face-background 'hl-line "#3e4446")
    (set-face-foreground 'hl-line nil)))

(defun agg-set-background-color-light ()
  (progn
    (load-theme 'spacemacs-light t)

    (set-face-attribute  'mode-line
                         nil
                         :box '(:line-width 1 :style released-button))
    (set-face-attribute  'mode-line-inactive
                         nil
                         :box '(:line-width 1 :style released-button))

    (set-face-background 'hl-line "#e6e600")
    (set-face-foreground 'hl-line nil)))

(defun agg-toggle-background-color ()
  "Toggle background and foreground colors between light and dark."
  (interactive)
  ;; use a property “state”. Value is t or nil
  (if (get 'agg-toggle-background-color 'state)
      (progn
        (agg-set-background-color-light)
        (put 'agg-toggle-background-color 'state nil))
    (progn
      (agg-set-background-color-dark)
      (put 'agg-toggle-background-color 'state t))))

;; Align your code in a pretty way.
(global-set-key (kbd "C-x \\") 'align-regexp)

;; Completion that uses many different methods to find options.
(global-set-key (kbd "M-/") 'hippie-expand)

;; Perform general cleanup.
(global-set-key (kbd "C-c n") 'cleanup-buffer)

;; Use regex searches by default.
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)

;; Buffers
(global-set-key (kbd "C-c y") 'bury-buffer)
(global-set-key (kbd "C-c r") 'revert-buffer)
(global-set-key (kbd "M-`") 'file-cache-minibuffer-complete)
; Use ibuffer which is better than switch buffer
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; Insert
(global-set-key "\C-x\M-d" `insdate-insert-current-date)

;; Window switching. (C-x o goes to the next window)
(windmove-default-keybindings) ;; Shift+direction
(global-set-key (kbd "C-x O") (lambda () (interactive) (other-window -1))) ;; back one
(global-set-key (kbd "C-x C-o") (lambda () (interactive) (other-window 2))) ;; forward two

;; Start eshell or switch to it if it's active.
(global-set-key (kbd "C-x m") 'eshell)

;; Start a new eshell even if one is active.
(global-set-key (kbd "C-x M") (lambda () (interactive) (eshell t)))

;; Start a regular shell if you prefer that.
(global-set-key (kbd "C-x M-m") 'shell)

;; If you want to be able to M-x without meta (phones, etc)
(global-set-key (kbd "C-x C-m") 'execute-extended-command)

;; Fetch the contents at a URL, display it raw.
(global-set-key (kbd "C-x C-h") 'view-url)

;; Help should search more than just commands
(global-set-key (kbd "C-h a") 'apropos)

;; Should be able to eval-and-replace anywhere.
(global-set-key (kbd "C-c e") 'eval-and-replace)

;; For debugging Emacs modes
(global-set-key (kbd "C-c p") 'message-point)

;; Comment or uncomment region
(global-set-key (kbd "C-c C-;") 'comment-or-uncomment-region)

;; Activate occur easily inside isearch
(define-key isearch-mode-map (kbd "C-o")
  (lambda () (interactive)
    (let ((case-fold-search isearch-case-fold-search))
      (occur (if isearch-regexp isearch-string (regexp-quote isearch-string))))))

;; Org
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)

(define-key global-map (kbd "C-M-+") 'text-scale-increase)
(define-key global-map (kbd "C-M-_") 'text-scale-decrease)

                                        ;(global-set-key "\C-q" 'backward-kill-word)

;;Permanently, force TAB to insert just one TAB (in every mode):
(global-set-key (kbd "TAB") 'tab-to-tab-stop)

;;Opens browser to url
(global-set-key (kbd "C-x C-u") 'browse-url)
(global-set-key (kbd "C-c C-o") 'browse-url)

;;Toggles whitespace
(global-set-key (kbd "C-c w") 'whitespace-mode)

;; Launch a new shell. Use "C-u" to be prompted for the shell's name
(global-set-key [f2] 'shell)

;; Refresh file from disk
(global-set-key [f5] 'revert-buffer)

;; Moves current buffer to last buffer
(global-set-key [f6] 'bury-buffer)

;; Moves last buffer to current buffer
(global-set-key [f7] 'unbury-buffer)

;; In shell, moves the prompt to the line of previously executed command
(global-set-key [f8] 'comint-previous-prompt)

(global-set-key [f9] 'undo)

(global-set-key [f11] 'whitespace-mode)

;; Unset F10 for tmux chicanery
;; https://superuser.com/questions/1142577/bind-caps-lock-key-to-tmux-prefix-on-macos-sierra
(global-unset-key [f10])

(global-set-key [f12] 'toggle-truncate-lines)

(global-set-key (kbd "C--") 'back-window)

(global-set-key (kbd "C-=") 'other-window)

(global-set-key (kbd "s-p") 'previous-buffer)

(global-set-key (kbd "s-n") 'next-buffer)

(global-set-key (kbd "C-x C-l") 'log-region)

;; Two approaches are discussed here for local key bindings
;; http://stackoverflow.com/questions/9818307/emacs-mode-specific-custom-key-bindings-local-set-key-vs-define-key

;; This is a general approach to binding a specific key binding to one
;; or more modes. Should be used in this file.
;; (defun my/bindkey-recompile ()
;;   "Bind <F5> to `recompile'."
;;   (local-set-key (kbd "<f5>") 'recompile))
;; (add-hook 'c-mode-common-hook 'my/bindkey-recompile)

(use-package auto-complete
  :ensure t
  :init
  (setq ac-ignore-case nil)
  :config
  (add-to-list 'ac-dictionary-directories
    "~/.emacs.d/auto-complete-config/dict")
  (ac-config-default))

(use-package deadgrep
  :ensure t
  :init
  (global-set-key (kbd "<f10>") #'deadgrep))

(use-package smartparens
  :ensure t
  :defer t
  :init
  (require 'smartparens-config))

(use-package yasnippet
  :ensure t
  :defer t)

(use-package feature-mode
  :ensure t
  :defer t)

(use-package docker
  :ensure t
  :defer t)

(use-package dockerfile-mode
  :ensure t
  :defer t)

(use-package json-mode
  :ensure t
  :defer t
  :init
  (add-hook 'json-mode-hook '(lambda ()
                                     (setq indent-tabs-mode nil)
                                     (setq tab-width 2)
                                     (setq indent-line-function (quote insert-tab))
                                     (local-set-key (kbd "C-c C-f") 'json-pretty-print-buffer))))

(use-package json-reformat
  :init
  (customize-set-variable 'json-reformat:indent-width 2))

(use-package terraform-mode
  :ensure
  :defer)

(use-package nxml-mode
  :mode "\\.xml\\'"
  :init
  (defun agg/xml-format ()
    "Format an XML buffer with xmllint."
    (interactive)
    (shell-command-on-region (point-min) (point-max)
                             "xmllint -format -"
                             (current-buffer) t
                             "*Xmllint Error Buffer*" t))
  (add-hook 'nxml-mode-hook 'progmodes-hooks)
  :bind (:map nxml-mode-map
              ("C-c C-l" . agg/xml-format)))

(use-package auto-complete-nxml
  :ensure t
  :defer t
  :after (auto-complete))

(use-package yaml-mode
  :ensure t
  :defer t)

(use-package mustache-mode
  :ensure t
  :defer t)

(use-package clojure-mode
  :ensure t
  :defer t
  :after (paredit)
  :init
  (add-hook 'clojure-mode-hook #'smartparens-mode))

;; avoid clojure-mode-extra-font-locking if using CIDER

(use-package cider
  :ensure t
  :defer t
  :init
  (setq clojure-indent-style :always-indent)
  (setq cider-repl-use-pretty-printing t)
  (setq cider-repl-wrap-history t)
  (setq cider-repl-history-size 1000)
  (setq cider-repl-history-file "~/.cider-repl-history.txt"))

(customize-set-variable 'css-indent-offset 2)

(add-hook 'html-mode-hook 'turn-off-auto-fill)
(add-hook 'html-mode-hook 'progmodes-hooks)

;; (use-package org-preview-html)

;; (use-package web-mode
;;   :ensure t
;;   :defer t)

(add-hook 'java-mode-hook (lambda ()
                            (setq c-basic-offset 4
                                  tab-width 4)))

(use-package eclim
  :ensure t
  :defer t
  :init
  (setq eclimd-autostart nil)
  (setq eclim-eclipse-dirs '("/Applications/SpringToolSuite4.app/Contents/Eclipse"))
  (setq eclim-executable "/Applications/SpringToolSuite4.app/Contents/Eclipse/plugins/org.eclim_2.8.0/bin/eclim")
  (setq eclim-auto-save t)
  (setq eclim-use-yasnippet t)
  ;; display compilation error messages in the echo area
  (setq help-at-pt-display-when-idle t)
  (setq help-at-pt-timer-delay 0.1)
  (defun my-java-mode-hook ()
    (eclim-mode t))
  (add-hook 'java-mode-hook 'my-java-mode-hook)
  (add-hook 'java-mode-hook 'progmodes-hooks)
  :config
  (help-at-pt-set-timer))

(use-package ac-emacs-eclim
  :ensure t
  :defer t
  :after (auto-complete eclim)
  :config
  (ac-emacs-eclim-config))

(use-package js2-mode
  :ensure t
  :defer t
  :after (auto-complete smartparens)
  :init
  (setq js2-strict-missing-semi-warning nil)
  (setq js2-missing-semi-one-line-override nil)
  (add-to-list 'ac-modes 'js2-mode)
  (add-hook 'js2-mode-hook 'progmodes-hooks)
  (add-hook 'js2-mode-hook #'smartparens-mode)
  (add-hook 'js2-mode-hook (lambda () (setq js2-basic-offset 2))))

(use-package tern
  :ensure t
  :defer t
  :config
  (define-key tern-mode-keymap (kbd "M-.") nil)
  (define-key tern-mode-keymap (kbd "M-,") nil)
  (add-hook 'js2-mode-hook (lambda () (tern-mode t))))

(use-package tern-auto-complete
  :ensure t
  :defer t
  :after (auto-complete tern)
  :init
  (setq tern-command "/usr/local/bin/tern")
  :config
  (tern-ac-setup))

(use-package js2-refactor
  :ensure t
  :defer t
  :after (js2-mode)
  :init
  (setq js2-skip-preprocessor-directives t)
  (js2r-add-keybindings-with-prefix "C-c C-m")
  (add-hook 'js2-mode-hook #'js2-refactor-mode))

(use-package rjsx-mode
  :ensure t
  :defer t
  :after (auto-complete smartparens)
  :init
  (setq js2-strict-missing-semi-warning nil)
  (setq js2-missing-semi-one-line-override nil)
  (add-to-list 'ac-modes 'rjsx-mode)
  (add-to-list 'auto-mode-alist '("\\.js\\'" . rjsx-mode))
  (add-to-list 'auto-mode-alist '("\\.jsx?\\'" . rjsx-mode))
  (add-to-list 'interpreter-mode-alist '("node" . rjsx-mode))
  (add-hook 'rjsx-mode 'progmodes-hooks)
  (add-hook 'rjsx-mode #'smartparens-mode)
  (add-hook 'rjsx-mode (lambda () (setq js2-basic-offset 2))))

(use-package eslint-fix
  :ensure t
  :defer t)

(use-package eslintd-fix
  :ensure t
  :defer t)

(use-package react-snippets
  :ensure t
  :defer t
  :after (yasnippet))

(use-package markdown-mode
  :ensure t
  :defer t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "/usr/local/bin/markdown"))

;; Every time I save the markdown file, I want to export it to an HTML file for viewing.
;;
;; This re-binds the normal 'save-buffer' key-chord to call
;; 'markdown-export'. It works because 'markdown-export' calls
;; 'save-buffer' in addition to exporting to HTML.
;; (eval-after-load 'markdown
;;   '(progn
;;      (define-key markdown-mode-map (kbd "C-x C-s") 'markdown-export)))

;;(define-key markdown-mode-map (kbd "C-x C-s") 'markdown-export)

(use-package markdown-preview-eww
  :ensure t
  :defer t)

(use-package puppet-mode
  :ensure t
  :defer t
  :init
  (add-to-list 'auto-mode-alist '("\\.pp$" . puppet-mode)))

(defun enh-ruby-mode-before-save-hook ()
    (when (eq major-mode 'enh-ruby-mode)
      (message (current-buffer))
      (rubocop-autocorrect-current-file)))

(defun enh-ruby-mode-hooks ()
  "Hooks for ruby programming"
  (add-hook 'before-save-hook 'enh-ruby-mode-before-save-hook))

(use-package enh-ruby-mode
  :ensure t
  :defer t
  :init
  ;; (add-to-list 'ac-modes 'enh-ruby-mode)
  (add-to-list 'auto-mode-alist '("\\.rb$" . enh-ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.gemspec$" . enh-ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.rake$" . enh-ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.ru$" . enh-ruby-mode))
  (add-to-list 'auto-mode-alist '("Capfile$" . enh-ruby-mode))
  (add-to-list 'auto-mode-alist '("Gemfile$" . enh-ruby-mode))
  (add-to-list 'auto-mode-alist '("Rakefile$" . enh-ruby-mode))
  (add-hook 'enh-ruby-mode-hook #'rubocop-mode)
  ;; (add-hook 'enh-ruby-mode-hook 'enh-ruby-mode-hooks) ;; Auto-formatting for rubocop broke whitespace-cleanup
  (add-hook 'enh-ruby-mode-hook 'progmodes-hooks))

(use-package inf-ruby
  :ensure t
  :defer t
  :init
  (add-hook 'enh-ruby-mode-hook 'inf-ruby-minor-mode))

(use-package yari
  :ensure t
  :defer t
  ;; C-h R
  :init (define-key 'help-command "R" 'yari))

(use-package rubocop
  :ensure t
  :defer t)

(use-package robe
  :ensure t
  :defer t
  :after (enh-ruby-mode auto-complete)
  :init
  (add-hook 'enh-ruby-mode-hook 'robe-mode)
  (add-hook 'enh-robe-mode-hook 'ac-robe-setup)
  :config
  (defadvice inf-ruby-console-auto (before activate-rvm-for-robe activate)
    (rvm-activate-corresponding-ruby)))

(use-package rvm
  :disabled
  :ensure t
  :defer t
  :init
  (add-hook 'enh-ruby-mode-hook (lambda ()
                                  (rvm-activate-corresponding-ruby)))
  :config
  (rvm-use-default))

(use-package haml-mode
  :ensure t
  :defer t)

(use-package coffee-mode
  :ensure t
  :defer t
  :after (whitespace-mode)
  :init
  ;; automatically clean up bad whitespace
  (setq whitespace-action '(auto-cleanup))
  ;; only show bad whitespace
  (setq whitespace-style '(trailing space-before-tab indentation empty space-after-tab)))

(use-package scala-mode
  :ensure t
  :defer t
  :init
  (add-to-list 'auto-mode-alist '("\\.sbt$" . scala-mode))
  (add-hook 'scala-mode-hook 'progmodes-hooks)
  :interpreter ("scala" . scala-mode)) ;;  :pin melpa-stable

(use-package sbt-mode
  :ensure t
  :defer t) ;;:pin melpa-stable

(use-package ensime
  :disabled
  :ensure t
  :defer t
  :init
  (add-hook 'scala-mode-hook 'ensime-scala-mode-hook)) ;;:pin melpa-stable

;; (setq
;;  ensime-sbt-command "/home/agoodno/src/ccap3/sbt"
;;  sbt:program-name "/home/agoodno/src/ccap3/sbt"
;;  ensime-startup-notification nil)

(setq auto-mode-alist (cons '("\\.psql$" . sql-mode) auto-mode-alist))

(add-hook 'sql-mode-hook 'turn-off-auto-fill)
(add-hook 'sql-mode-hook 'progmodes-hooks)

(provide 'agg-sql-mode)

(setq js-indent-level 2)
(add-hook 'js-mode-hook 'progmodes-hooks)

(use-package vue-mode
  :ensure t
  :defer t
  :init
  (add-hook 'vue-mode-hook 'progmodes-hooks)
  :config
  ;; 0, 1, or 2, representing (respectively) none, low, and high coloring
  (setq mmm-submode-decoration-level 0))

;; (defvar freenode-password "")
;; (defvar bitlbee-password "")

(setq
 erc-server "irc.wicourts.gov"
 ;; erc-server "chat.freenode.net"
 erc-nick "agoodno"
 erc-prompt (lambda () (concat "[" (buffer-name) "]"))
 ;; erc-prompt-for-nickserv-password nil
 ;; erc-nickserv-passwords `((freenode ("agoodno" . ,freenode-password)))
 erc-email-userid "andrew.goodnough@wicourts.gov"
 ;; erc-email-userid "agoodno@gmail.com"
 erc-user-full-name "Andrew Goodnough"
 ;; erc-autojoin-channels-alist '(("irc.wicourts.gov" "#ccap3" "#cc"))
 erc-autojoin-channels-alist
 '(("freenode.net" "#emacs" "#elasticsearch")
   ("wicourts.gov" "#ccap3" "#cc"))
 ;; erc-join-buffer 'bury
 erc-hide-list '("QUIT" "JOIN" "KICK" "NICK" "MODE")
 erc-echo-notices-in-minibuffer-flag t
 erc-auto-query 'buffer
 erc-save-buffer-on-part nil
 erc-save-queries-on-quit nil
 erc-log-write-after-send t
 erc-log-write-after-insert t
 erc-fill-column 75
 erc-header-line-format nil
 erc-track-exclude-types '("324" "329" "332" "333" "353" "477" "MODE"
                           "JOIN" "PART" "QUIT" "NICK")
 ;; erc-lurker-threshold-time 3600
 ;; erc-track-priority-faces-only t
 ;; erc-autojoin-timing :ident
 ;; erc-flood-protect nil
 ;; erc-server-send-ping-interval 45
 ;; erc-server-send-ping-timeout 180
 ;; erc-server-reconnect-timeout 60
 ;; erc-server-flood-penalty 1000000
 ;; erc-accidental-paste-threshold-seconds 0.5
 erc-fill-function 'erc-fill-static
 erc-fill-static-center 14)

(defun freenode-connect ()
  "Connect to freenode."
  (interactive)
  (erc :server "irc.freenode.net" :port 6667 :nick "agoodno"))

(defun bitlbee-connect ()
  "Connect to bitlbee."
  (interactive)
  (erc :server "127.0.0.1" :port 6667))

(defun wicourts-connect ()
  "Connect to wicourts."
  (interactive)
  (erc :server "irc.wicourts.gov" :port 6667 :nick "agoodno"))

;;(add-hook 'erc-join-hook 'bitlbee-identify)

(defun bitlbee-identify ()
  "If we're on the bitlbee server, send the identify command to the &bitlbee channel."
  (when (and (string= "127.0.0.1" erc-session-server)
             (string= "&bitlbee" (buffer-name)))
    (erc-message "PRIVMSG" (format "%s identify %s"
                                   (erc-default-target)
                                   bitlbee-password))))

;; (delete 'erc-fool-face 'erc-track-faces-priority-list)
;; (delete '(erc-nick-default-face erc-fool-face) 'erc-track-faces-priority-list)

;; (eval-after-load 'erc
;;   '(progn
;;      ;; (when (not (package-installed-p 'erc-hl-nicks))
;;      ;;   (package-install 'erc-hl-nicks))
;;      (require 'erc-spelling)
;;      (require 'erc-services)
;;      (require 'erc-truncate)
;;      ;; (require 'erc-hl-nicks)
;;      (require 'notifications)
;;      (erc-services-mode 1)
;;      (erc-truncate-mode 1)
;;      (setq erc-complete-functions '(erc-pcomplete erc-button-next))
;;      ;; (add-to-list 'erc-modules 'hl-nicks)
;;      (add-to-list 'erc-modules 'spelling)
;;      (set-face-foreground 'erc-input-face "dim gray")
;;      (set-face-foreground 'erc-my-nick-face "blue")
;;      (define-key erc-mode-map (kbd "C-c r") 'pnh-reset-erc-track-mode)
;;      (define-key erc-mode-map (kbd "C-c C-M-SPC") 'erc-track-clear)
;;      (define-key erc-mode-map (kbd "C-u RET") 'browse-last-url-in-brower)))

;; (defun erc-track-clear ()
;;   (interactive)
;;   (setq erc-modified-channels-alist nil))

;; (defun browse-last-url-in-brower ()
;;   (interactive)
;;   (require 'ffap)
;;   (save-excursion
;;     (let ((ffap-url-regexp "\\(https?://\\)."))
;;       (ffap-next-url t t))))

;; (defun pnh-reset-erc-track-mode ()
;;   (interactive)
;;   (setq erc-modified-channels-alist nil)
;;   (erc-modified-channels-update)
;;   (erc-modified-channels-display))

;; (require 'erc-services)
;; (erc-services-mode 1)

;; ;;; Notify me when a keyword is matched (someone wants to reach me)

;; (defvar my-erc-page-message "%s says %s"
;;   "Format of message to display in dialog box")

;; (defvar my-erc-page-nick-alist nil
;;   "Alist of nicks and the last time they tried to trigger a notification")

;; (defvar my-erc-page-timeout 60
;;   "Number of seconds that must elapse between notifications from the same person.")

;; (defun my-erc-page-popup-notification (message)
;;   (when window-system
;;     ;; must set default directory, otherwise start-process is unhappy
;;     ;; when this is something remote or nonexistent
;;     (let ((default-directory "~/"))
;;       ;; 8640000 milliseconds = 1 day
;;       (start-process "page-me" nil "notify-send"
;;                      "-u" "normal" "-t" "8640000" "ERC"
;;                      (format my-erc-page-message (car (split-string nick "!")) message)))))

;; (defun my-erc-page-allowed (nick &optional delay)
;;   "Return non-nil if a notification should be made for NICK.
;; If DELAY is specified, it will be the minimum time in seconds
;; that can occur between two notifications.  The default is
;; `my-erc-page-timeout'."
;;   (unless delay (setq delay my-erc-page-timeout))
;;   (let ((cur-time (time-to-seconds (current-time)))
;;         (cur-assoc (assoc nick my-erc-page-nick-alist))
;;         (last-time))
;;     (if cur-assoc
;;         (progn
;;           (setq last-time (cdr cur-assoc))
;;           (setcdr cur-assoc cur-time)
;;           (> (abs (- cur-time last-time)) delay))
;;       (push (cons nick cur-time) my-erc-page-nick-alist)
;;       t)))

;; (defun my-erc-page-me (match-type nick message)
;;   "Notify the current user when someone sends a message that
;; matches a regexp in `erc-keywords'."
;;   (interactive)
;;   (when (and (eq match-type 'keyword)
;;              ;; I don't want to see anything from the erc server
;;              (null (string-match "\\`\\([sS]erver\\|localhost\\)" nick))
;;              ;; or bots
;;              (null (string-match "\\(bot\\|serv\\)!" nick))
;;              ;; or from those who abuse the system
;;              (my-erc-page-allowed nick))
;;     (my-erc-page-popup-notification message)))
;; (add-hook 'erc-text-matched-hook 'my-erc-page-me)

;; (defun my-erc-page-me-PRIVMSG (proc parsed)
;;   (let ((nick (car (erc-parse-user (erc-response.sender parsed))))
;;         (target (car (erc-response.command-args parsed)))
;;         (msg (erc-response.contents parsed)))
;;     (when (and (erc-current-nick-p target)
;;                (not (erc-is-message-ctcp-and-not-action-p msg))
;;                (my-erc-page-allowed nick))
;;       (my-erc-page-popup-notification msg)
;;       nil)))
;; (add-hook 'erc-server-PRIVMSG-functions 'my-erc-page-me-PRIVMSG)

;; (eval-after-init
;;  '(and
;;                                         ; (add-to-list 'erc-modules 'autoaway)
;;    (add-to-list 'erc-modules 'autojoin)
;;    (add-to-list 'erc-modules 'button)
;;    (add-to-list 'erc-modules 'completion)
;;    (add-to-list 'erc-modules 'fill)
;;    (add-to-list 'erc-modules 'irccontrols)
;;    (add-to-list 'erc-modules 'list)
;;    (add-to-list 'erc-modules 'log)
;;    (add-to-list 'erc-modules 'match)
;;    (add-to-list 'erc-modules 'menu)
;;    (add-to-list 'erc-modules 'move-to-prompt)
;;    (add-to-list 'erc-modules 'netsplit)
;;    (add-to-list 'erc-modules 'networks)
;;    (add-to-list 'erc-modules 'noncommands)
;;    (add-to-list 'erc-modules 'notify)
;;    (add-to-list 'erc-modules 'readonly)
;;    (add-to-list 'erc-modules 'ring)
;;    (add-to-list 'erc-modules 'stamp)
;;    (add-to-list 'erc-modules 'track )
;;    (erc-update-modules)))

;; (customize-set-variable 'erc-server "irc.freenode.net")
;; (customize-set-variable 'erc-port 6667)
;; (customize-set-variable 'erc-nick "agoodno")

;; (use-package erc-hipchatify
;;   :ensure t
;;   :defer t
;;   :init
;;   (progn
;;     ;; (customize-set-variable 'shr-use-fonts f)
;;     ;; (customize-set-variable 'shr-external-browser "")
;;     (add-to-list 'erc-modules 'hipchatify)
;;     (erc-update-modules)))

;; How to get a token
;; https://github.com/yuya373/emacs-slack#how-to-get-token

;; Works by issuing command (slack-start), then enter Team: and Token:
;; but doesn't work with the token in team config below for some reason
(use-package slack
  :disabled
  :ensure t
  :defer t
  :commands (slack-start)
  :init
  (setq slack-buffer-emojify t)
  (setq slack-prefer-current-team t)
  :config
  (slack-register-team
   :name slack-elmlang-team
   :client-id slack-elmlang-client-id
   :client-secret slack-elmlang-client-secret
   :token slack-elmlang-token
   :full-and-display-names t)
  (slack-register-team
   :name slack-cucumberbdd-team
   :default t
   :client-id slack-cucumberbdd-client-id
   :client-secret slack-cucumberbdd-client-secret
   :token slack-cucumberbdd-token
   :full-and-display-names t
   :subscribed-channels '(announcements events help intros podcasts-and-webinars recommended_media school)))

(use-package mu4e
  :disabled
  :init
  (setq mu4e-mu-binary "/usr/local/bin/mu"
        mu4e-get-mail-command "mbsync gmail"
        mu4e-maildir (expand-file-name "~/mbsync")
        mu4e-change-filenames-when-moving t
        mu4e-update-interval 300)
  (add-to-list 'load-path "/usr/local/share/emacs/site-lisp/mu/mu4e"))

;; Open links in Chrome on macOS
;; (setq gnus-button-url 'browse-url-generic
;;       browse-url-generic-program "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
;;       browse-url-browser-function gnus-button-url)

;; Open links in Safari
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "open")

(use-package exec-path-from-shell
  :ensure t
  :config
  (exec-path-from-shell-initialize)
  ;; Make ansi-term play nice with zsh prompt.
  (defadvice ansi-term (after advise-ansi-term-coding-system)
    (set-buffer-process-coding-system 'utf-8-unix 'utf-8-unix)))

(use-package f
  :ensure t)

(use-package flycheck
  :ensure t
  :init
  (setq flycheck-javascript-eslint-executable "~/work/wastewitness/node_modules/.bin/eslint")
  (setq flycheck-javascript-standard-executable "~/work/wastewitness/node_modules/.bin/standard")
  (setq-default flycheck-disabled-checkers
    '(emacs-lisp-checkdoc))
  (setq-default flycheck-disabled-checkers
    (append flycheck-disabled-checkers
    '(javascript-jshint)))
  (setq-default flycheck-disabled-checkers
    (append flycheck-disabled-checkers
    '(json-jsonlist)))
  (global-flycheck-mode))

(use-package flycheck-clojure
  :ensure t
  :defer t
  :after (flycheck)
  :config (flycheck-clojure-setup))

(use-package ido
  :ensure t
  :init
  ;; File finding
  (global-set-key (kbd "C-x M-f") 'ido-find-file-other-window)
  (global-set-key (kbd "C-x f") 'recentf-ido-find-file)
  :config
  (ido-mode 1)
  (ido-everywhere 1)
  (icomplete-mode 1))

(use-package ido-completing-read+
  :ensure t
  :after (ido)
  :init
  (ido-ubiquitous-mode 1))

(use-package ido-vertical-mode
  :ensure t
  :after (ido)
  :init
  (setq ido-vertical-define-keys 'C-n-and-C-p-only)
  :config
  (ido-vertical-mode 1))

(use-package magit
  :ensure t
  :init
  (setq magit-completing-read-function 'magit-ido-completing-read)
  (customize-set-variable 'magit-display-buffer-function
    (quote magit-display-buffer-fullframe-status-v1))
  (customize-set-variable 'magit-status-sections-hook
    '(magit-insert-status-headers
      magit-insert-merge-log
      magit-insert-rebase-sequence
      magit-insert-am-sequence
      magit-insert-sequencer-sequence
      magit-insert-bisect-output
      magit-insert-bisect-rest
      magit-insert-unpulled-from-upstream
      magit-insert-unpulled-from-pushremote
      magit-insert-unpushed-to-upstream
      magit-insert-unpushed-to-pushremote
      magit-insert-staged-changes
      magit-insert-unstaged-changes
      magit-insert-untracked-files
      magit-insert-stashes))
  (customize-set-variable 'magit-repolist-columns
    (quote
      (("Name" 40 magit-repolist-column-ident nil)
      ("Path" 99 magit-repolist-column-path))))
  (customize-set-variable 'magit-repository-directories
    magit-projects)
  (global-set-key (kbd "C-c g") 'magit-status)
  (global-set-key (kbd "C-c h") 'magit-list-repositories))

(use-package org
  :init
  (setq org-log-done 'time)
  (setq org-log-done 'note)
  (setq org-todo-keywords
        '((sequence "IDEA" "TODO" "PLANNING" "DESIGNING" "PROGRAMMING" "WAITING" "TESTING" "CHECKLIST" "MR" "APPROVED" "|" "MERGED" "DELEGATED" "DONE" "CANCELED")))
  (setq org-log-done nil)
  :bind (("C-c l" . org-store-link)
         ("C-c c" . org-capture)
         ("C-c a" . org-agenda)
         ("C-c t" . ins-tommorrows-date)
         ("C-c d" . insdate-insert-current-date)
         :map org-mode-map
         ("C-c !" . org-time-stamp-inactive))
  :mode ("\\.org$" . org-mode)
  :config
  (require 'org-id))
  ;; (require 'ob-sh)
  ;; (org-babel-do-load-languages 'org-babel-load-languages '((shell . t)))

(use-package pdf-tools
  :disabled
  :ensure t
  :defer t
  :init
  (pdf-tools-install))

(use-package projectile
  :ensure t
  :config
  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (projectile-mode +1))

(use-package restclient
  :ensure t
  :defer t)

(setq save-place-file (locate-user-emacs-file "places" ".emacs-places"))

(save-place-mode 1)

;;; Fix junk characters in shell-mode
;; Add color to a shell running in emacs 'M-x shell'
;;; Shell mode
;; (setq ansi-color-names-vector ; better contrast colors
;;       ["black" "red4" "green4" "yellow4"
;;        "blue3" "magenta4" "cyan4" "white"])
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)

;; Fixes npm commands that attempt to color interactive user prompts
;; ...but messes with sbt and awk among others
;; (add-to-list
;;          'comint-preoutput-filter-functions
;;          (lambda (output)
;;            (replace-regexp-in-string "\033\\[[0-9]+[A-Z]" "" output)))

;; Fixes some bad characters appearing when color prompts are used
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; Makes the prompt read-only running in emacs 'M-x shell'
(add-hook 'shell-mode-hook
     '(lambda () (toggle-truncate-lines 1)))
(setq comint-prompt-read-only t)

(use-package smex
  :ensure t
  :init (smex-initialize)
  (global-set-key (kbd "M-x") 'smex)
  (global-set-key (kbd "M-X") 'smex-major-mode-commands)
  (global-set-key (kbd "C-c C-c M-x") 'execute-extended-command))

(setq tidy-shell-command "/usr/local/bin/tidy")
(setq tidy-config-file "~/.tidyrc")
(setq tidy-temp-directory "/tmp")

(setq tramp-default-method "ssh")

(defun connect-patproc-test ()
  (interactive)
  (dired "/lcbuser@patproc-test-host.library.wisc.edu:/opt/patproc-test/"))

(use-package unfill
  :ensure t)

(setq uniquify-buffer-name-style 'forward)

(agg-set-background-color-light)
;; uncomment this for dark mode
(agg-toggle-background-color)
(server-start)
