;; my key bindings

;;; starter-kit-bindings.el --- Set up some handy key bindings
;;
;; Part of the Emacs Starter Kit.

;; You know, like Readline.
(global-set-key (kbd "C-M-h") 'backward-kill-word)

;; Align your code in a pretty way.
(global-set-key (kbd "C-x \\") 'align-regexp)

;; Completion that uses many different methods to find options.
(global-set-key (kbd "M-/") 'hippie-expand)

;; Perform general cleanup.
(global-set-key (kbd "C-c n") 'cleanup-buffer)

;; Turn on the menu bar for exploring new modes
(global-set-key (kbd "C-<f10>") 'menu-bar-mode)

;; ;; Font size
;; (define-key global-map (kbd "C-+") 'text-scale-increase)
;; (define-key global-map (kbd "C--") 'text-scale-decrease)

;; Use regex searches by default.
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "\C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)

;; Jump to a definition in the current file. (This is awesome.)
(global-set-key (kbd "C-x C-i") 'ido-imenu)

;; File finding
(global-set-key (kbd "C-x M-f") 'ido-find-file-other-window)
(global-set-key (kbd "C-x C-M-f") 'find-file-in-project)
(global-set-key (kbd "C-x f") 'recentf-ido-find-file)
(global-set-key (kbd "C-c y") 'bury-buffer)
(global-set-key (kbd "C-c r") 'revert-buffer)
(global-set-key (kbd "M-`") 'file-cache-minibuffer-complete)
(global-set-key (kbd "C-x C-b") 'ibuffer)

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

;; So good!
(global-set-key (kbd "C-x g") 'magit-status)

;; This is a little hacky since VC doesn't support git add internally
(eval-after-load 'vc
  (define-key vc-prefix-map "i" '(lambda () (interactive)
                                   (if (not (eq 'Git (vc-backend buffer-file-name)))
                                       (vc-register)
                                     (shell-command (format "git add %s" buffer-file-name))
                                     (message "Staged changes.")))))

;; Activate occur easily inside isearch
(define-key isearch-mode-map (kbd "C-o")
  (lambda () (interactive)
    (let ((case-fold-search isearch-case-fold-search))
      (occur (if isearch-regexp isearch-string (regexp-quote isearch-string))))))

;; Org
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)

(provide 'starter-kit-bindings)
;;; starter-kit-bindings.el ends here

(define-key global-map (kbd "C-M-+") 'text-scale-increase)
(define-key global-map (kbd "C-M-_") 'text-scale-decrease)

                                        ;(global-set-key "\C-q" 'backward-kill-word)

;;Permanently, force TAB to insert just one TAB (in every mode):
(global-set-key (kbd "TAB") 'tab-to-tab-stop)

;;Opens browser to url
(global-set-key (kbd "C-x C-u") 'browse-url)

(global-set-key [f5] 'revert-buffer)

(global-set-key [f6] 'bury-buffer)

(global-set-key [f7] 'blank-mode)

(global-set-key [f8] 'comint-previous-prompt)

(global-set-key [f9] 'undo)

(global-set-key [f12] 'toggle-truncate-lines)

(defun back-window ()
  (interactive)
  (other-window -1))

(global-set-key (kbd "C--") 'back-window)

(global-set-key (kbd "C-=") 'other-window)

(global-set-key (kbd "M-p") 'previous-buffer)

(global-set-key (kbd "M-n") 'next-buffer)

(global-set-key (kbd "C-c g") 'magit-status)

(defun alt-shell-dwim (arg)
  "Run an inferior shell like `shell'. If an inferior shell as its I/O
through the current buffer, then pop the next buffer in `buffer-list'
whose name is generated from the string \"*shell*\". When called with
an argument, start a new inferior shell whose I/O will go to a buffer
named after the string \"*shell*\" using `generate-new-buffer-name'."
  (interactive "P")
  (let* ((shell-buffer-list
          (let (blist)
            (dolist (buff (buffer-list) blist)
              (when (string-match "^\\*shell\\*" (buffer-name buff))
                (setq blist (cons buff blist))))))
         (name (if arg
                   (generate-new-buffer-name "*shell*")
                 (car shell-buffer-list))))
    (shell name)))

;; http://www.emacswiki.org/emacs/ShellMode#toc3
;; (global-set-key [f7] 'alt-shell-dwim)

;; Create a symbol by which this script can be referenced by a require
(provide 'agg-bindings)
