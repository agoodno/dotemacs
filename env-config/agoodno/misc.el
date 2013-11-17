(defun make-reviewed-by (args)
  "Constructs the reviewed by line to commit messages

Example: Reviewed by pbrant, tward, azoerb"
  (let (reviewed-by (string "Reviewed-by: %s"))
  (format "Reviewed-by: %s\n" (mapconcat 'identity (split-string args " ") ", "))))

(defvar reviewers-history nil)

(defun insert-reviewed-by (args)
  "Adds the reviewed by line to commit messages"
  (interactive (list
    (read-from-minibuffer "Enter reviewers: " (car reviewers-history) nil nil 'reviewers-history)))
  (insert (make-reviewed-by args)))

(eval-after-load 'git-commit-mode
  '(define-key git-commit-mode-map (kbd "C-x C-r") 'insert-reviewed-by))
