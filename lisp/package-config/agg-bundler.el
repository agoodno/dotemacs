;; My bundler is at: /Users/agoodnough/.gem/ruby/2.1.1/bin/bundle
;; but the pacakge can't find it and expects it to on the path.
;; It's probably missing this setup from my .bashrc
;;  source '/usr/local/share/chruby/chruby.sh'
;;  source '/usr/local/share/chruby/auto.sh'
;; Otherwise, I could hack the bundler.el to set the path to bunlder
;; or allow setting it with a variable
(use-package bundler
  :ensure t
  :defer t)

(provide 'agg-bundler)
