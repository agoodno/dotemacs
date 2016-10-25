;; Turn off menu
(menu-bar-mode -1)

;; Turn off tool-bar
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))

;; Turn off scroll-bar
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))

;; Bell preference

;; Use default audible bell
;; (setq visible-bell nil)

;; Use a visible bell instead of audible bell
;; (setq visible-bell t)

;; Ignore bell usingn 'ignore function
;; (setq ring-bell-function 'ignore)

;; Play a wav file on bell
;; (setq ring-bell-function (lambda ()
;;                            (call-process "afplay" nil 0 nil
;;                                          "/Users/agoodnough/Dropbox/emacs-bell.mp3")))

;; (setq ring-bell-function (lambda ()
;;                            (call-process "afplay" nil 0 nil
;;                                          "/Users/agoodnough/Dropbox/emacs-bell2.mp3")))

(defun friendly-visible-bell ()
  "A friendlier visual bell effect."
  (invert-face 'mode-line)
  (run-with-timer 0.1 nil 'invert-face 'mode-line))

(setq visible-bell nil
      ring-bell-function #'friendly-visible-bell)

(show-paren-mode 1)
(setq-default indent-tabs-mode nil)
(setq x-select-enable-clipboard t
      ;; x-select-enable-primary t ;;causes problems with delete-selection-mode
      save-interprogram-paste-before-kill nil
      apropos-do-all t
      mouse-yank-at-point nil)

;; Paste and backspace operations delete the selection and "pastes over" it
(delete-selection-mode t)

;; Stop splash screen
(setq inhibit-splash-screen t)

;; Sets the scratch message to empty string
(setq initial-scratch-message nil)

;; See http://www.delorie.com/gnu/docs/elisp-manual-21/elisp_620.html
;; and http://www.gnu.org/software/emacs/manual/elisp.pdf
;; disable line wrap
(setq default-truncate-lines t)

;; Shows extra whitespace in normal (non-whitepace mode) buffer as a warning
;; This would be fine but should do only for prog mode files
;;(setq show-trailing-whitespace t)

;; Make side by side buffers function the same as the main window
(setq truncate-partial-width-windows nil)

;; highlight selected regions and add special behaviors to regions.
(setq transient-mark-mode t)

;; Display line and column numbers
(setq line-number-mode t)
(setq column-number-mode t)

;; Indent with spaces, never with TABs
(setq-default indent-tabs-mode nil)

;; Sets basic offset
(setq c-basic-offset 2)

;; Indent to 2 spaces
(setq-default tab-width 2)

;; Tabs stop every 2 spaces
(setq-default tab-stop-list (quote (2 4 6 8 10)))

;; "y or n" instead of "yes or no"
(defalias 'yes-or-no-p 'y-or-n-p)

(setq split-width-threshold nil)

(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

(provide 'agg-look-and-feel-sound-and-color)

;; (setq ring-bell-function (lambda ()
;;   (set-face-background 'default "DodgerBlue")
;;   (set-face-foreground 'default "black")))
