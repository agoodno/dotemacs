(use-package ruby-mode
  :ensure t
  :defer t
  :init (add-to-list 'auto-mode-alist '("\\.gemspec$" . ruby-mode))
    (add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))
    (add-to-list 'auto-mode-alist '("\\.ru$" . ruby-mode))
    (add-to-list 'auto-mode-alist '("Capfile$" . ruby-mode))
    (add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))
    (add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))
    (add-hook 'ruby-mode-hook 'progmodes-hooks))

(provide 'agg-ruby-mode)
