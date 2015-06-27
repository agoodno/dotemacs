;; my key bindings

;; Align your code in a pretty way.
(global-set-key (kbd "C-x \\") 'align-regexp)

;; Completion that uses many different methods to find options.
(global-set-key (kbd "M-/") 'hippie-expand)

;; Perform general cleanup.
(global-set-key (kbd "C-c n") 'cleanup-buffer)

;; Turn on the menu bar for exploring new modes
(global-set-key (kbd "C-<f10>") 'menu-bar-mode)

;; Use regex searches by default.
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)

;; Jump to a definition in the current file. (This is awesome.)
(global-set-key (kbd "C-x C-i") 'ido-imenu)

;; File finding
(global-set-key (kbd "C-x M-f") 'ido-find-file-other-window)
(global-set-key (kbd "C-x C-M-f") 'find-file-in-project)
(global-set-key (kbd "C-x f") 'recentf-ido-find-file)

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

;; So good!
(global-set-key (kbd "C-x g") 'magit-status)

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

;;Toggles whitespace
(global-set-key (kbd "C-c w") 'whitespace-mode)

(global-set-key [f5] 'revert-buffer)

(global-set-key [f6] 'bury-buffer)

(global-set-key [f7] 'whitespace-mode)

(global-set-key [f8] 'comint-previous-prompt)

(global-set-key [f9] 'undo)

(global-set-key [f10] 'shell)

(global-set-key [f12] 'toggle-truncate-lines)

(defun back-window ()
  (interactive)
  (other-window -1))

(global-set-key (kbd "C--") 'back-window)

(global-set-key (kbd "C-=") 'other-window)

(global-set-key (kbd "s-p") 'previous-buffer)

(global-set-key (kbd "s-n") 'next-buffer)

(global-set-key (kbd "C-c g") 'magit-status)

;; Two approaches are discussed here for local key bindings
;; http://stackoverflow.com/questions/9818307/emacs-mode-specific-custom-key-bindings-local-set-key-vs-define-key

;; This is a general approach to binding a specific key binding to one
;; or more modes. Should be used in this file.
;; (defun my/bindkey-recompile ()
;;   "Bind <F5> to `recompile'."
;;   (local-set-key (kbd "<f5>") 'recompile))
;; (add-hook 'c-mode-common-hook 'my/bindkey-recompile)

;; This is a general approach for binding a specific key binding for
;; use in one mode. Should be used in the package-config/<mode>.el file.
;; (eval-after-load "org-mode"
;;   '(progn
;;      (define-key org-mode-map (kbd "C-c t") 'ins-tommorrows-date)))
;;      (define-key org-mode-map (kbd "C-c d") 'insdate-insert-current-date)

;; Create a symbol by which this script can be referenced by a require
(provide 'agg-bindings)
