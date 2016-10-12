(use-package enh-ruby-mode
  :ensure t
  :defer t
  :init (add-to-list 'auto-mode-alist '("\\.gemspec$" . enh-ruby-mode))
    (add-to-list 'auto-mode-alist '("\\.rake$" . enh-ruby-mode))
    (add-to-list 'auto-mode-alist '("\\.ru$" . enh-ruby-mode))
    (add-to-list 'auto-mode-alist '("Capfile$" . enh-ruby-mode))
    (add-to-list 'auto-mode-alist '("Gemfile$" . enh-ruby-mode))
    (add-to-list 'auto-mode-alist '("Rakefile$" . enh-ruby-mode))
    (add-hook 'enh-ruby-mode-hook 'progmodes-hooks))

(provide 'agg-enh-ruby-mode)
