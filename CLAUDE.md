# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal Emacs configuration using **literate programming** with Org-mode. The configuration is written as an Org document with embedded elisp code blocks.

## Architecture

- **`init.el`** - Minimal entry point that loads the literate config via `(org-babel-load-file "~/.emacs.d/agginit.org")`
- **`agginit.org`** - Main configuration file (literate programming format). This is where all configuration changes should be made.
- **`agginit.el`** - Auto-generated from `agginit.org` via org-babel tangling. Do not edit directly.
- **`custom.el`** - Machine-specific settings managed by Emacs customize system. Not committed to git.

## Package Management

Uses `use-package` with MELPA and GNU ELPA repositories. Pattern:
```elisp
(use-package package-name
  :ensure t
  :config ...)
```

## Custom Variables

Machine-specific configuration uses the `agg` custom group:
```elisp
(defcustom variable-name "default"
  "Description"
  :type 'string
  :group 'agg)
```

Access via `M-x customize-group RET agg`.

## CI/CD

GitHub Actions workflow (`.github/workflows/check.yml`) runs on push:
- Tests `init.el` loads successfully
- Tests `init.el` byte-compiles without errors
- Runs against Emacs 27.1 and snapshot

## Making Changes

1. Edit `agginit.org` (the org file, not the generated .el file)
2. Reload config with `M-x org-babel-load-file RET ~/.emacs.d/agginit.org` or restart Emacs
3. The org file is organized hierarchically by topic - find the appropriate section before adding new configuration
