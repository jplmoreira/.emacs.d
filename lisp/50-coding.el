;;; -*- lexical-binding: t; -*-

;; Rust
(use-package rust-ts-mode
  :straight t
  :custom
  (rust-format-on-save t))

;; Dockerfile
(use-package dockerfile-mode :straight t)

;; YAML
(use-package yaml-mode
  :straight t
  :mode "\\.ya?ml\\'")

;; Go
(use-package go-ts-mode
  :straight t
  :mode "\\.go\\'")

;; Typescript
(use-package typescript-ts-mode
  :straight t
  :mode "\\.tsx?\\'"
  :custom
  (typescript-indent-level 2))

;; JSON
(use-package json-mode :straight t)

(use-package eglot
  :straight t
  :commands eglot
  :hook
  ((sh-mode
    c-mode
    c++-mode
    python-ts-mode

    go-ts-mode
    rust-ts-mode
    json-mode
    typescript-ts-mode
    ) . eglot-ensure)
  :general
  (jpl/leader-keys
    :keymaps 'eglot-mode-map
    "sc" 'eglot-reconnect
    "ss" 'eglot-shutdown
    "sr" 'eglot-rename
    "st" 'eglot-format
    "sa" 'eglot-code-actions
    "sh" 'eglot-hover-eldoc-function
    "sfi" 'eglot-find-implementation
    "sft" 'eglot-find-typeDefinition
    "sfr" 'xref-find-references
    "sfp" 'xref-find-apropos
    "sfd" 'xref-find-definitions
    "sj" 'flymake-goto-next-error
    "sk" 'flymake-goto-prev-error)
  :config
  (setq completion-category-overrides '((eglot (styles orderless)))))

;; (use-package consult-eglot
;;   :after (eglot consult)
;;   :straight t
;;   :general
;;   (jpl/leader-keys
;;     :keymaps 'eglot-mode-map
;;     "sy" 'consult-eglot-symbols))
