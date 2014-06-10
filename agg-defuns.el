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

(defun shell-dir (name dir)
  "Opens a shell into the specified directory"
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

;; Create a symbol by which this script can be referenced by a require
(provide 'agg-defuns)
