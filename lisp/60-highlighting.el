;;; -*- lexical-binding: t; -*-

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
