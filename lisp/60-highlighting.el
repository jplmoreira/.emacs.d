;;; -*- lexical-binding: t; -*-

(use-package evil-goggles
  :straight t
  :after evil
  :config
  (evil-goggles-mode))

(use-package rainbow-delimiters
  :straight t
  :hook
  (prog-mode . rainbow-delimiters-mode))

(use-package whitespace
  :ensure nil
  :hook
  (prog-mode . whitespace-mode)
  :config
  (setq whitespace-style '(face empty lines-tail trailing))
  (setq whitespace-line-column 100))

(use-package highlight-leading-spaces
  :straight t
  :hook
  (prog-mode . highlight-leading-spaces-mode))

(use-package tree-sitter
  :if (version< emacs-version "29")
  :demand t
  :straight t
  :hook (after-init . global-tree-sitter-mode)
  :hook (tree-sitter-after-on . tree-sitter-hl-mode))

(use-package tree-sitter-langs
  :if (version< emacs-version "29")
  :after tree-sitter
  :demand t
  :straight t)

(use-package treesit-auto
  :if (not (version< emacs-version "29"))
  :straight t
  :custom (treesit-auto-install t)
  :config
  (setq treesit-auto-langs '(python rust go typescript tsx gomod))
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))
