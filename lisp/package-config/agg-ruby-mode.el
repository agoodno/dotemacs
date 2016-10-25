;;(setq ruby-use-smie nil)
;;(setq ruby-align-to-stmt-keywords t)

(add-to-list 'auto-mode-alist '("\\.gemspec$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.ru$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Capfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))
;;(add-hook 'ruby-mode-hook #'aggressive-indent-mode)
(add-hook 'ruby-mode-hook 'progmodes-hooks)

(defun rails-console-in (dir name)
  "Opens a rails console in the specified directory with name"
;  (interactive "P")
  (let ((default-directory dir))
;        (buffer-name (if name name "Console")))
    (chruby-use-corresponding)
    (async-shell-command "bundle exec rails console" name)))

;(rails-console-in "/Users/agoodnough/src/customerservice/" "repl-customerservice")
;(rails-console-in "/Users/agoodnough/src/mar-api/" "repl-mar-api")

(defun rails-console (name)
  "Opens a rails console in the specified directory with name"
  (chruby-use-corresponding)
  (async-shell-command "bundle exec rails console" name))

;(rails-console "repl-customerservice")

(defun m-test-one-current-buffer ()
  "Runs test"
  (interactive)
  (let ((default-directory "/Users/agoodnough/src/customerservice/"))
  (chruby-use-corresponding)
  (async-shell-command (format "bundle exec m %s" buffer-file-name))))

(defun m-test-all-current-buffer ()
  "Runs test"
  (interactive)
  (let ((default-directory "/Users/agoodnough/src/customerservice/"))
  (chruby-use-corresponding)
  (async-shell-command "bundle exec rake test")))

(defun run-foreman ()
  "Run foreman in an async buffer."
  (interactive)
  (let ((default-directory "/Users/agoodnough/src/customerservice/"))
  (async-shell-command "foreman start" "*Foreman*")))

(defun bundle-command (cmd)
  "Run cmd in an async buffer."
  (let ((default-directory (git-project-root)))
  (chruby-use-corresponding)
  (setenv "AWS_DEFAULT_REGION" "us-east-1")
  (async-shell-command cmd "*Bundler*")))

(defun show-dir (dir)
  "Show the full path file name in the minibuffer."
  (message dir))

(defun git-project-root? (path)
  "Finds the git project root starting in path"
  (let ((git-dir (concat (file-name-as-directory path) ".git")))
  (show-dir git-dir)
  (f-exists? git-dir)))

(defun git-project-root ()
  (f-traverse-upwards 'git-project-root?))

(eval-after-load "ruby-mode"
  '(progn
    (define-key ruby-mode-map (kbd "C-c C-t") 'm-test-one-current-buffer)
    (define-key ruby-mode-map (kbd "C-c C-a") 'm-test-all-current-buffer)
    (define-key ruby-mode-map (kbd "C-c C-f") 'run-foreman)))

(provide 'agg-ruby-mode)
