(defun eval-after-init (form)
  "Add `(lambda () FORM)' to `after-init-hook'.

If Emacs has already finished initialization, also eval FORM immediately."
  (let ((func (list 'lambda nil form)))
    (add-hook 'after-init-hook func)
    (when after-init-time
      (eval form))))

;; Create a symbol by which this script can be referenced by a require
(provide 'agg-defuns)
