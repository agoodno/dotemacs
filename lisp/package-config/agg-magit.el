(use-package magit
  :ensure t
  :init
  (load "~/.magit-projects")
  (customize-set-variable 'magit-display-buffer-function
    (quote magit-display-buffer-fullframe-status-v1))
  (customize-set-variable 'magit-status-sections-hook
    '(magit-insert-status-headers
      magit-insert-merge-log
      magit-insert-rebase-sequence
      magit-insert-am-sequence
      magit-insert-sequencer-sequence
      magit-insert-bisect-output
      magit-insert-bisect-rest
      magit-insert-bisect-log
      magit-insert-unpulled-from-upstream
      magit-insert-unpulled-from-pushremote
      magit-insert-unpushed-to-upstream
      magit-insert-unpushed-to-pushremote
      magit-insert-staged-changes
      magit-insert-unstaged-changes
      magit-insert-untracked-files
      magit-insert-stashes))
  (customize-set-variable 'magit-repolist-columns
    (quote
      (("Name" 40 magit-repolist-column-ident nil)
      ("Path" 99 magit-repolist-column-path))))
  (customize-set-variable 'magit-repository-directories
    magit-projects)
  (global-set-key (kbd "C-c g") 'magit-status)
  (global-set-key (kbd "C-c l") 'magit-list-repositories))

(provide 'agg-magit)
