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

(defun jpl/treesit-auto-install-rust (langs)
  (setq treesit-auto-langs (cons 'rust langs))
  (treesit-auto-install-all)
  (setq treesit-auto-langs langs))

(use-package treesit-auto
  :if (not (version< emacs-version "29"))
  :straight t
  :custom (treesit-auto-install t)
  :config
  (jpl/treesit-auto-install-rust '(python go typescript tsx gomod))
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))
