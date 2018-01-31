;; Distributed with GNU Emacs

(setq tramp-default-method "ssh")

(defun connect-patproc-test ()
  (interactive)
  (dired "/lcbuser@patproc-test-host.library.wisc.edu:/opt/patproc-test/"))

(provide 'agg-tramp)
