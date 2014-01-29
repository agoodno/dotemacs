(defun eval-after-init (form)
  "Add `(lambda () FORM)' to `after-init-hook'.

If Emacs has already finished initialization, also eval FORM immediately."
  (let ((func (list 'lambda nil form)))
    (add-hook 'after-init-hook func)
    (when after-init-time
      (eval form))))

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

;; Create a symbol by which this script can be referenced by a require
(provide 'agg-defuns)
