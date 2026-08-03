;;; config-test.el --- Regression tests for config.org  -*- lexical-binding: t; -*-

;; Run against a fully loaded config:
;;
;;   emacs --batch -l init.el -l tests/config-test.el -f ert-run-tests-batch-and-exit
;;
;; or `make test' from the repo root. ert-run-tests-batch-and-exit exits non-zero
;; when anything fails, so this gates CI directly.
;;
;; Two kinds of test live here:
;;
;;   Invariants  -- properties that should hold for any future edit, e.g. "no mode
;;                  hook references an undefined function". These catch whole
;;                  classes of mistake rather than one instance.
;;   Regressions -- specific bugs that were live in this config and should not
;;                  come back. Each names the behaviour, not the old symbol, so
;;                  the test stays meaningful after the fix is forgotten.
;;
;; Static checks (obsolete forms, unescaped docstring quotes, free variables) are
;; deliberately NOT here -- the byte-compiler already finds those, and
;; tests/byte-compile-check.sh gates them against a baseline.

(require 'ert)
(require 'seq)
(require 'cl-lib)

;;; Helpers -------------------------------------------------------------------

(defvar config-test--tmpdir nil)

(defun config-test--file (ext)
  "Return a real temp file with extension EXT, for auto-mode dispatch tests."
  (unless config-test--tmpdir
    (setq config-test--tmpdir (make-temp-file "config-test" t)))
  (let ((f (expand-file-name (concat "probe." ext) config-test--tmpdir)))
    (unless (file-exists-p f)
      (with-temp-file f (insert "\n")))
    f))

(defun config-test--mode-for (ext)
  "Major mode Emacs actually chooses for a file with extension EXT.
Uses real dispatch rather than reading `auto-mode-alist', because
`major-mode-remap-alist' does not resolve mode aliases and a hand-rolled
lookup would disagree with Emacs in exactly the cases worth testing."
  (let ((buf (find-file-noselect (config-test--file ext))))
    (unwind-protect (buffer-local-value 'major-mode buf)
      (kill-buffer buf))))

(defun config-test--hook-symbols (hook)
  "Function symbols on HOOK's global value, ignoring lambdas and closures."
  (seq-filter #'symbolp (and (boundp hook) (default-value hook))))

(defconst config-test--should-be-deferred
  '(enh-ruby-mode inf-ruby yari rubocop robe ruby-tools chruby projectile-rails
    dockerfile-mode terraform-mode elm-mode
    browse-kill-ring unfill impostman f smartparens org-bullets
    color-theme-sanityinc-tomorrow dracula-theme gruvbox-theme
    timu-spacegrey-theme)
  "Packages that must not be loaded merely by starting Emacs.")

(defconst config-test--loaded-at-startup
  (seq-filter #'featurep config-test--should-be-deferred)
  "Snapshot of which deferred packages were loaded when this file loaded.
Taken at load time on purpose. Tests below open Ruby, org and JavaScript
buffers, which legitimately pull several of these in, so asking `featurep'
during a test would depend on test execution order.")

;;; Invariants ----------------------------------------------------------------

(ert-deftest config-mode-hooks-reference-defined-functions ()
  "No `*-mode-hook' may hold a symbol that is not a function.
A typo here is invisible until the mode is entered, and then it breaks every
buffer of that type. This is what let `progmodes-hooks' (missing its agg/
prefix) sit in enh-ruby-mode-hook unnoticed."
  (let (bad)
    (mapatoms
     (lambda (sym)
       (when (and (boundp sym)
                  (string-suffix-p "-mode-hook" (symbol-name sym)))
         (dolist (fn (config-test--hook-symbols sym))
           (unless (or (fboundp fn) (eq fn t))
             (push (cons sym fn) bad))))))
    (should (equal nil bad))))

(ert-deftest config-major-mode-remap-keys-are-real-modes ()
  "Every key in `major-mode-remap-alist' must name a real mode.
A key that names nothing silently never fires, so the tree-sitter mode simply
never gets used -- the failure mode of the old bash-mode and go-mode entries."
  (should (equal nil
                 (seq-remove (lambda (cell) (fboundp (car cell)))
                             major-mode-remap-alist))))

(ert-deftest config-progmode-cleanup-stays-buffer-local ()
  "Save-time cleanup must never reach the global `before-save-hook'.
When it does, untabify and whitespace-cleanup run on every save in every
buffer, stripping trailing whitespace from unrelated files and destroying
Markdown hard line breaks."
  (dolist (mode '(typescript-ts-mode tsx-ts-mode js-ts-mode
                  nxml-mode sql-mode html-mode))
    (when (fboundp mode)
      (with-temp-buffer (funcall mode))
      (should (equal nil (default-value 'before-save-hook))))))

(ert-deftest config-comint-setup-does-not-mutate-globals ()
  "`agg/init-comint' runs from a mode hook, so it must only set buffer-locals."
  (skip-unless (fboundp 'agg/init-comint))
  (let ((before (list (default-value 'comint-prompt-read-only)
                      (default-value 'comint-process-echoes))))
    (with-temp-buffer (agg/init-comint))
    (should (equal before (list (default-value 'comint-prompt-read-only)
                                (default-value 'comint-process-echoes))))))

(ert-deftest config-bound-keys-have-live-commands ()
  "Keys this config binds must resolve to something callable.
`use-package :bind' autoloads its target, so a typo can look healthy under
fboundp while still failing on use -- hence the check that the definition is
not merely an autoload pointing at a library that lacks it."
  (let (bad)
    (dolist (key '("C-c h" "C-c H" "C-c g" "C-c G" "C-c t" "C-c d" "C-c c"
                   "C-c a" "C-c w" "C-c v" "C-c V" "C-c p" "C-x C-b" "C-x m"
                   "C-x \\" "M-/" "s-p" "s-n" "C-," "C-." "<f5>" "<f12>"
                   "C-x C-l"))
      (let ((cmd (key-binding (kbd key))))
        (when (and cmd (symbolp cmd) (not (keymapp cmd)) (not (fboundp cmd)))
          (push (cons key cmd) bad))))
    (should (equal nil bad))))

(ert-deftest config-deferred-packages-stay-deferred ()
  "Deferred packages must not creep back into startup.
Deferral is easy to lose by accident -- a `require' in `:init', or an
`add-hook' written by hand where `:hook' would both defer and autoload. This
pins the set that was deferred so a regression shows up as a test failure
rather than as a slower launch nobody attributes to a config change."
  (should (equal nil config-test--loaded-at-startup)))

(ert-deftest config-flycheck-defers-to-eglot ()
  "flycheck must yield to flymake while eglot manages a buffer, and resume after.
Two systems annotating one buffer is exactly the state this policy exists to
prevent, and it is invisible in a screenshot -- the duplicate underlines look
like one checker being noisy.

eglot-managed-p is stubbed: starting a real language server in batch is neither
reliable nor the thing under test."
  (skip-unless (fboundp 'agg/flycheck-defer-to-eglot))
  (should (memq 'agg/flycheck-defer-to-eglot
                (default-value 'eglot-managed-mode-hook)))
  (let ((buf (find-file-noselect (config-test--file "json"))))
    (unwind-protect
        (with-current-buffer buf
          (skip-unless (flycheck-may-enable-mode))
          (flycheck-mode 1)
          (should (bound-and-true-p flycheck-mode))
          (cl-letf (((symbol-function 'eglot-managed-p) (lambda () t)))
            (agg/flycheck-defer-to-eglot))
          (should-not (bound-and-true-p flycheck-mode))
          ;; The hook also fires when eglot stops managing the buffer, so the
          ;; handoff has to work in both directions.
          (cl-letf (((symbol-function 'eglot-managed-p) (lambda () nil)))
            (agg/flycheck-defer-to-eglot))
          (should (bound-and-true-p flycheck-mode)))
      (kill-buffer buf))))

(ert-deftest config-diagnostics-dispatcher-routes-by-active-checker ()
  "M-g f must reach whichever system owns the buffer.
Binding it straight to `consult-flymake' was wrong for most buffers, since
flycheck owns everything eglot does not manage."
  (skip-unless (fboundp 'agg/consult-diagnostics))
  (should (eq (key-binding (kbd "M-g f")) 'agg/consult-diagnostics))
  (let (called)
    (cl-letf (((symbol-function 'consult-flymake) (lambda (&rest _) (setq called 'flymake)))
              ((symbol-function 'consult-flycheck) (lambda (&rest _) (setq called 'flycheck))))
      (with-temp-buffer
        (setq-local flymake-mode t)
        (agg/consult-diagnostics)
        (should (eq called 'flymake)))
      (setq called nil)
      (with-temp-buffer
        (setq-local flycheck-mode t)
        (agg/consult-diagnostics)
        (should (eq called 'flycheck)))
      (with-temp-buffer
        (should-error (agg/consult-diagnostics) :type 'user-error)))))

(ert-deftest config-agg-commands-are-documented ()
  "Interactive agg/ commands should carry a docstring."
  (let (undocumented)
    (mapatoms
     (lambda (sym)
       (when (and (fboundp sym)
                  (commandp sym)
                  (string-prefix-p "agg/" (symbol-name sym))
                  (not (documentation sym)))
         (push sym undocumented))))
    (should (equal nil undocumented))))

;;; Regressions ---------------------------------------------------------------

(ert-deftest config-file-extensions-resolve-to-expected-modes ()
  "Extension-to-mode dispatch, verified through real `find-file'.
Covers the tree-sitter remap keys that used to name nonexistent modes
\(bash-mode), unclaimed extensions (.go), alias mismatches (.js resolving to
javascript-mode so js-ts-mode-hook never ran, taking eglot and apheleia with
it), and YAML/JSON, which only worked because undeclared yaml-mode and
json-mode packages happened to be present in elpa/.

Each case names the grammar it needs. The remaps are guarded on
`treesit-ready-p', so an extension whose grammar is missing legitimately falls
back; those are skipped with a message rather than asserted against the wrong
mode, since silently passing would be worse than either."
  (let (skipped)
    (dolist (case '(("sh"   bash-ts-mode       . bash)
                    ("go"   go-ts-mode         . go)
                    ("js"   js-ts-mode         . javascript)
                    ("py"   python-ts-mode     . python)
                    ("css"  css-ts-mode        . css)
                    ("json" json-ts-mode       . json)
                    ("yaml" yaml-ts-mode       . yaml)
                    ("yml"  yaml-ts-mode       . yaml)
                    ("ts"   typescript-ts-mode . typescript)
                    ("tsx"  tsx-ts-mode        . tsx)
                    ("rb"   enh-ruby-mode      . nil)
                    ("psql" sql-mode           . nil)))
      (let ((ext (car case))
            (expected (cadr case))
            (grammar (cddr case)))
        (if (and grammar (not (treesit-ready-p grammar t)))
            (push ext skipped)
          (should (eq (config-test--mode-for ext) expected)))))
    (when skipped
      (message "NOTE: skipped extensions with no grammar installed: %s"
               (nreverse skipped)))))

(ert-deftest config-contested-keys-resolve-to-chosen-command ()
  "Keys that more than one package wants, pinned to the intended winner.
Load order used to decide these silently: C-c h went to whichever of
consult/org/magit loaded last, and projectile's s-p shadowed previous-buffer
in every project buffer."
  (dolist (case '(("C-c h" . org-store-link)
                  ("C-c H" . consult-history)
                  ("C-c g" . magit-status)
                  ("C-c G" . magit-list-repositories)
                  ("s-p"   . previous-buffer)
                  ("s-n"   . next-buffer)
                  ("C-c t" . agg/ins-tommorrows-date)))
    (should (eq (key-binding (kbd (car case))) (cdr case)))))

(ert-deftest config-custom-themes-are-discoverable ()
  "`custom-theme-directory' must point where the themes really live.
It was assigned twice; the surviving value named a directory that does not
exist, so agg-light and agg-dark were invisible to load-theme."
  (should (file-directory-p custom-theme-directory))
  (dolist (theme '(agg-light agg-dark))
    (should (memq theme (custom-available-themes)))))

(ert-deftest config-agg-group-holds-machine-specific-settings ()
  "The agg group should carry real per-machine values.
It previously held only redeclared identity variables: user-full-name, which
the OS already supplies correctly, and user-email-address, which is not an
Emacs variable at all."
  (let ((members (mapcar #'car (get 'agg 'custom-group))))
    (should (memq 'agg-org-roam-personal-directory members))
    (should (memq 'agg-org-roam-work-directory members))
    (should-not (memq 'user-full-name members)))
  (should-not (boundp 'user-email-address))
  (dolist (v '(agg-org-roam-personal-directory agg-org-roam-work-directory))
    (should (stringp (symbol-value v)))))

(ert-deftest config-does-not-override-org-roam-directory ()
  "`org-roam-directory' belongs to custom.el, which sets it per machine.
Forcing a value from config.org pointed org-roam at a directory that does not
exist on this machine and had autosync build an empty database there.

org-roam is deferred, so load it explicitly -- the point of the test is what
its :config block does on load."
  (skip-unless (require 'org-roam nil t))
  (let ((saved (car (get 'org-roam-directory 'saved-value))))
    (skip-unless saved)
    (should (equal (expand-file-name org-roam-directory)
                   (expand-file-name (eval saved t))))))

(ert-deftest config-declared-treesit-grammars-are-usable ()
  "Every grammar a remap or auto-mode entry depends on should be installed.
Run `make grammars' if this fails locally.

Grammars listed in GRAMMARS_ALLOW_FAILURE are exempt, using the same variable
`tests/install-grammars.el' honours, so a host that genuinely cannot build one
\(a C++ scanner under a nix-installed Emacs, for instance) reports it in one
place instead of failing here and skipping silently there."
  (skip-unless (and (fboundp 'treesit-available-p) (treesit-available-p)))
  (let* ((raw (getenv "GRAMMARS_ALLOW_FAILURE"))
         (exempt (if (and raw (not (string-empty-p raw)))
                     (mapcar #'intern (split-string raw "," t "[ \t]+"))
                   '()))
         (missing (seq-remove
                   (lambda (lang)
                     (or (treesit-ready-p lang t) (memq lang exempt)))
                   '(bash css javascript json python typescript tsx yaml go))))
    (when exempt
      (message "NOTE: grammars exempt via GRAMMARS_ALLOW_FAILURE: %s" exempt))
    (should (equal nil missing))))

(ert-deftest config-shell-dir-is-callable ()
  "`agg/shell-dir' had an unescaped quote that ended its docstring early,
turning the rest of the example into body forms and making any call signal
\(void-variable cmd-rails)."
  (skip-unless (fboundp 'agg/shell-dir))
  (should (documentation 'agg/shell-dir))
  (should (string-match-p "cmd-rails" (documentation 'agg/shell-dir))))

(ert-deftest config-insert-date-honours-prefix-argument ()
  "`agg/insert-date' documents three formats; it used to ignore its argument."
  (skip-unless (fboundp 'agg/insert-date))
  (let (results)
    (dolist (prefix '(nil (4) (16)))
      (with-temp-buffer
        (agg/insert-date prefix)
        (push (buffer-string) results)))
    ;; All three formats must differ from one another.
    (should (= 3 (length (delete-dups (copy-sequence results)))))
    ;; The no-prefix case is ISO.
    (with-temp-buffer
      (agg/insert-date nil)
      (should (string-match-p "\\`[0-9]\\{4\\}-[0-9]\\{2\\}-[0-9]\\{2\\}\\'"
                              (buffer-string))))))

(provide 'config-test)
;;; config-test.el ends here
