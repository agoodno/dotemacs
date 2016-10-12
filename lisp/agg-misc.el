(setq user-full-name "Andrew Goodnough"
      user-mail-address "agoodno@gmail.com")

(ido-mode t)
(setq ido-enable-flex-matching t)

(menu-bar-mode -1)
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))

(show-paren-mode 1)
(setq-default indent-tabs-mode nil)
(setq x-select-enable-clipboard t
      ;; x-select-enable-primary t ;;causes problems with delete-selection-mode
      save-interprogram-paste-before-kill nil
      apropos-do-all t
      mouse-yank-at-point nil)

;; Changes backups to go to a backup directory
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))

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

;; Shows extra whitespace in normal (non-whitepace mode) buffer as a warning
;; This would be fine but should do only for prog mode files
;;(setq show-trailing-whitespace t)

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
(defalias 'yes-or-no-p 'y-or-n-p)

(setenv "PAGER" "/bin/cat")

(setq split-width-threshold nil)

(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

(setq gnus-button-url 'browse-url-generic
      browse-url-generic-program "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
      browse-url-browser-function gnus-button-url)

(add-to-list 'auto-mode-alist '("\\.log\\'" . auto-revert-mode))

(provide 'agg-misc)
