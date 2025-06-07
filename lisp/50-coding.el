;;; -*- lexical-binding: t; -*-

;; Rust
(use-package rust-mode
  :straight t
  :mode "\\.rs\\'"
  :init
  (setq rust-mode-treesitter-derive t)
  :custom
  (rust-format-on-save t))

;; Zig
(use-package zig-mode
  :straight t
  :mode "\\.zig\\'")

;; Dockerfile
(use-package dockerfile-mode :straight t)

;; YAML
(use-package yaml-mode
  :straight t
  :mode "\\.ya?ml\\'")

;; Go
(use-package go-ts-mode
  :straight t
  :mode "\\.go\\'"
  :hook
  (before-save . gofmt-before-save)
  :custom
  (go-ts-mode-indent-offset 4))

;; Typescript
(use-package typescript-ts-mode
  :straight t
  :mode "\\.tsx?\\'"
  :custom
  (typescript-indent-level 2))

;; JSON
(use-package json-mode :straight t)

;; Protobuf
(use-package protobuf-mode :straight t)

;; Solidity
(use-package solidity-mode :straight t)

(use-package eglot
  :straight t
  :commands eglot
  :hook
  ((sh-mode
    c-mode
    c++-mode
    python-ts-mode

    go-ts-mode
    rust-mode
    zig-mode
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
  (setq completion-category-overrides '((eglot (styles orderless))))

  (add-to-list 'eglot-server-programs
               `(rust-mode . ("rust-analyzer" :initializationOptions
                              (:cargo (:loadOutDirsFromCheck (:enable t)))))
               `(c++-mode . ("clangd" "--style={NamespaceIndentation: Inner}"))
               ))

(use-package consult-eglot
  :after (eglot consult)
  :straight t
  :general
  (jpl/leader-keys
    :keymaps 'eglot-mode-map
    "sy" 'consult-eglot-symbols))
