;; my miscellaneous

(ido-mode t)
(setq ido-enable-flex-matching t)

(menu-bar-mode -1)
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))

(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

(require 'saveplace)
(setq-default save-place t)

(show-paren-mode 1)
(setq-default indent-tabs-mode nil)
(setq x-select-enable-clipboard t
      ;; x-select-enable-primary t ;;causes problems with delete-selection-mode
      save-interprogram-paste-before-kill t
      apropos-do-all t
      mouse-yank-at-point t
      save-place-file (concat user-emacs-directory "places")
      backup-directory-alist `(("." . ,(concat user-emacs-directory
                                               "backups"))))

(require 'bar-cursor)
(bar-cursor-mode 1)

;; paste and backspace operations delete the selection and "pastes over" it
(delete-selection-mode t)

;;Stop splash screen
(setq inhibit-splash-screen t)

;; sets the scratch message to empty string
(setq initial-scratch-message nil)

;; See http://www.delorie.com/gnu/docs/elisp-manual-21/elisp_620.html
;; and http://www.gnu.org/software/emacs/manual/elisp.pdf
;; disable line wrap
(setq default-truncate-lines t)

;; make side by side buffers function the same as the main window
(setq truncate-partial-width-windows nil)

;; highlight selected regions and add special behaviors to regions.
(setq transient-mark-mode t)

;; display line and column numbers
(setq line-number-mode t)
(setq column-number-mode t)

;;Indent with spaces, never with TABs
(setq-default indent-tabs-mode nil)

;;Sets basic offset
(setq c-basic-offset 2)

;;Indent to 2 spaces
(setq-default tab-width 2)

;;Tabs stop every 2 spaces
(setq-default tab-stop-list (quote (2 4 6 8 10)))

;; "y or n" instead of "yes or no"
(fset 'yes-or-no-p 'y-or-n-p)

;; ORG MODE
(setq org-log-done 'time)
(setq org-log-done 'note)
;; END ORG MODE

;; Add .psql to SQL mode
(setq auto-mode-alist (cons '("\\.psql$" . sql-mode) auto-mode-alist))

(defalias 'yes-or-no-p 'y-or-n-p)

;;; Fix junk characters in shell-mode
(add-hook 'shell-mode-hook
          'ansi-color-for-comint-mode-on)

;; Customize HTML mode
(add-hook 'html-mode-hook 'turn-off-flyspell)
(add-hook 'html-mode-hook 'turn-off-auto-fill)

;;http://www.emacswiki.org/cgi-bin/emacs-en/LoadPath
;;     (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
;;         (let* ((my-lisp-dir "~/elisp/")
;;               (default-directory my-lisp-dir))
;;            (setq load-path (cons my-lisp-dir load-path))
;;            (normal-top-level-add-subdirs-to-load-path)))

;;(autoload 'tail "tail" "Tail." t)

;; (add-to-list 'load-path "~/.emacs.d/rinari")
;; (require 'rinari)
;; (add-to-list 'auto-mode-alist '("\\.rb\\'" . ruby-mode))

;; (add-to-list 'load-path "~/.emacs.d/rhtml")
;; (require 'rhtml-mode)
;;   (add-hook 'rhtml-mode-hook
;;     (lambda () (rinari-launch)))
;; (add-to-list 'auto-mode-alist '("\\.rhtml\\.erb\\'" . rhtml-mode))

;;For Subversion support
(add-to-list 'vc-handled-backends 'SVN)

(setenv "PAGER" "/bin/cat")

(setq split-width-threshold nil)

(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

;; Add color to a shell running in emacs 'M-x shell'
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; Makes the prompt read-only running in emacs 'M-x shell'
(add-hook 'shell-mode-hook
     '(lambda () (toggle-truncate-lines 1)))
(setq comint-prompt-read-only t)

;; Add color to a shell running in emacs 'M-x shell'
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; Makes the prompt read-only running in emacs 'M-x shell'
(add-hook 'shell-mode-hook
     '(lambda () (toggle-truncate-lines 1)))
(setq comint-prompt-read-only t)

;; ;; scala mode hooks
;; (add-hook 'scala-mode-hook 'scala-turnoff-indent-tabs-mode)
;; ;; end Scala Mode

;; ;; Scala Mode
;; (add-to-list 'load-path "~/.emacs.d/custom/scala-mode")
;; (require 'scala-mode-auto)

;; (defun scala-turnoff-indent-tabs-mode ()
;;   (setq indent-tabs-mode nil))
;; ;; end Scala Mode

;; This step causes the ensime-mode to be started whenever
;; scala-mode is started for a buffer. You may have to customize this step
;; if you're not using the standard scala mode.
;(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)

;; MINI HOWTO:
;; Open .scala file. M-x ensime (once per project)
;; end ENSIME

;; Create a symbol by which this script can be referenced by a require
(provide 'agg-misc)
