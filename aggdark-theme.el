(deftheme aggdark
  "Created 2024-08-17.")

(custom-theme-set-faces
 'aggdark
 '(default ((t (:family "DejaVu Sans Mono" :foundry "PfEd" :width normal :height 98 :weight regular :slant normal :underline nil :overline nil :extend nil :strike-through nil :box nil :inverse-video nil :foreground "#b2b2b2" :background "#292b2e" :stipple nil :inherit nil))))
 '(cursor ((t (:background "#e3dedd"))))
 '(fixed-pitch ((t (:family "Monospace"))))
 '(variable-pitch ((((type w32)) (:foundry "outline" :family "Arial")) (t (:family "Sans Serif"))))
 '(escape-glyph ((((background dark)) (:foreground "cyan")) (((type pc)) (:foreground "magenta")) (t (:foreground "brown"))))
 '(homoglyph ((((background dark)) (:foreground "cyan")) (((type pc)) (:foreground "magenta")) (t (:foreground "brown"))))
 '(minibuffer-prompt ((t (:weight normal :foreground "#4f97d7" :inherit (bold)))))
 '(highlight ((t (:foreground "#b2b2b2" :background "#444155"))))
 '(region ((t (:extend t :background "white"))))
 '(shadow ((t (:foreground "#686868"))))
 '(secondary-selection ((t (:extend t :background "#100a14"))))
 '(trailing-whitespace ((t (:background "#e0211d"))))
 '(font-lock-bracket-face ((t (:foreground "#7c7f93"))))
 '(font-lock-builtin-face ((t (:foreground "#4f97d7"))))
 '(font-lock-comment-delimiter-face ((t (:inherit (shadow)))))
 '(font-lock-comment-face ((t (:slant normal :foreground "#2aa1ae" :background "#292e34" :inherit (shadow)))))
 '(font-lock-constant-face ((t (:foreground "#a45bad"))))
 '(font-lock-delimiter-face ((t (:foreground "#7c7f93"))))
 '(font-lock-doc-face ((t (:foreground "#9f8766" :inherit (font-lock-comment-face)))))
 '(font-lock-doc-markup-face ((t (:inherit (font-lock-constant-face)))))
 '(font-lock-escape-face ((t (:foreground "#ea76cb"))))
 '(font-lock-function-call-face ((t (:foreground "#1e66f5"))))
 '(font-lock-function-name-face ((t (:foreground "#bc6ec5" :inherit (bold)))))
 '(font-lock-keyword-face ((t (:slant normal :foreground "#4f97d7" :inherit (bold)))))
 '(font-lock-negation-char-face ((t (:foreground "#a45bad"))))
 '(font-lock-number-face ((t (:foreground "#fe640b"))))
 '(font-lock-misc-punctuation-face ((t (:inherit (font-lock-punctuation-face)))))
 '(font-lock-operator-face ((t (:foreground "#04a5e5"))))
 '(font-lock-preprocessor-face ((t (:foreground "#bc6ec5"))))
 '(font-lock-property-name-face ((t (:inherit (font-lock-variable-name-face)))))
 '(font-lock-property-use-face ((t (:inherit (font-lock-property-name-face)))))
 '(font-lock-punctuation-face ((t nil)))
 '(font-lock-regexp-grouping-backslash ((t (:foreground "#d20f39"))))
 '(font-lock-regexp-grouping-construct ((t (:foreground "#d20f39"))))
 '(font-lock-string-face ((t (:foreground "#2d9574"))))
 '(font-lock-type-face ((t (:foreground "#ce537a" :inherit (bold)))))
 '(font-lock-variable-name-face ((t (:foreground "#7590db"))))
 '(font-lock-variable-use-face ((t (:foreground "#4c4f69"))))
 '(font-lock-warning-face ((t (:foreground "#dc752f" :background "#292b2e" :inherit (warning)))))
 '(button ((t (:inherit (link)))))
 '(link ((t (:underline (:color foreground-color :style line :position nil) :foreground "#2aa1ae"))))
 '(link-visited ((t (:underline (:color foreground-color :style line :position nil) :foreground "#c56ec3"))))
 '(fringe ((t (:foreground "#b2b2b2" :background "#292b2e"))))
 '(header-line ((t (:background "#212026" :inherit (mode-line)))))
 '(tooltip ((t (:weight normal :slant normal :underline nil :foreground "#b2b2b2" :background "#5e5079"))))
 '(mode-line ((t (:box (:line-width (1 . 1) :color nil :style released-button) :foreground "gray25" :background "gray80"))))
 '(mode-line-buffer-id ((t (:foreground "#bc6ec5" :inherit (bold)))))
 '(mode-line-emphasis ((t (:weight bold))))
 '(mode-line-highlight ((((supports :box t) (class color) (min-colors 88)) (:box (:line-width (2 . 2) :color "grey40" :style released-button))) (t (:inherit (highlight)))))
 '(mode-line-inactive ((t (:box (:line-width (1 . 1) :color nil :style released-button) :inverse-video nil :foreground "gray80" :background "gray25"))))
 '(isearch ((t (:weight bold :foreground "#292b2e" :background "#86dc2f" :inherit (match)))))
 '(isearch-fail ((t (:inherit (error)))))
 '(lazy-highlight ((t (:foreground "#5c5f77" :background "#29422d"))))
 '(match ((t (:foreground "#86dc2f" :background "#444155"))))
 '(next-error ((t (:inherit (region)))))
 '(query-replace ((t (:inherit (isearch))))))

(provide-theme 'aggdark)
