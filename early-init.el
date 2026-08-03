;;; early-init.el --- Runs before package activation and the first frame -*- lexical-binding: t; -*-

;; Emacs 27+ loads this before `package-activate-all' and before the initial
;; frame is created. Only settings that must precede one of those belong here;
;; everything else lives in config.org.

;;; Garbage collection

;; Effectively disable GC for the duration of startup, then restore a working
;; threshold. This has to happen here: by the time init.el tangles and loads
;; config.org, most of startup's allocation has already been done, so the same
;; setting there missed the window it was meant to cover.
(setq gc-cons-threshold most-positive-fixnum)

(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (* 16 1024 1024))))

;;; Packages

;; `package-quickstart' must be set before `package-activate-all' runs, and
;; that happens after this file but before init.el. Setting it in config.org --
;; as this config did -- was always too late: activation had already taken the
;; slow path of scanning every directory under elpa/, and config.org's
;; `package-initialize' then scanned them a second time.
;;
;; `package-enable-at-startup' is deliberately left at its default t so that
;; activation does happen, and happens by the quickstart route. Note that under
;; `emacs --batch -l init.el' the startup guard also requires `user-init-file',
;; which is nil there, so batch runs rely on the guarded `package-initialize'
;; in config.org instead.
(setq package-quickstart t)

;;; Frame appearance

;; Set the chrome off via frame parameters rather than relying solely on
;; `menu-bar-mode' and friends. Those run from config.org, after the first
;; frame is already mapped, so the bars are drawn and then removed -- a visible
;; relayout on every launch. `default-frame-alist' is consulted before the
;; frame appears. config.org still calls the mode functions, which keeps the
;; mode variables consistent with what is actually on screen.
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)

;;; Native compilation

;; Set before any async native compilation can start.
(setq native-comp-async-report-warnings-errors nil)
(setq native-compile-prune-cache t)

(provide 'early-init)
;;; early-init.el ends here
