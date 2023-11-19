;;; -*- lexical-binding: t; -*-

;; Rust
(use-package rust-mode
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
(use-package go-mode
  :straight t
  :mode "\\.go\\'")

(use-package eglot
  :straight t
  :commands eglot
  :hook
  ((sh-mode
    c-mode
    c++-mode
    python-mode

    go-mode
    rust-mode
    ) . eglot-ensure)
  :general
  (jpl/leader-keys
    :keymaps 'eglot-mode-map
    "sc" 'eglot-reconnect
    "ss" 'eglot-shutdown
    "sr" 'eglot-rename
    "st" 'eglot-format
    "sa" 'eglot-code-actions
    "sh" 'eglot-help-at-point
    "sfi" 'eglot-find-implementation
    "sft" 'eglot-find-typeDefinition
    "sfr" 'xref-find-references
    "sfp" 'xref-find-apropos
    "sfd" 'xref-find-definitions
    "sj" 'flymake-goto-next-error
    "sk" 'flymake-goto-prev-error))

;; (use-package consult-eglot
;;   :after (eglot consult)
;;   :straight t
;;   :general
;;   (jpl/leader-keys
;;     :keymaps 'eglot-mode-map
;;     "sy" 'consult-eglot-symbols))
