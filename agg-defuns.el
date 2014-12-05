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

(calendar-current-date)

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
