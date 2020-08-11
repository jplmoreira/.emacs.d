(require 'eglot)

;; C/C++
(add-to-list 'eglot-server-programs '((c++-mode c-mode) . ("clangd")))
(add-hook 'c-mode-hook 'eglot-ensure)
(add-hook 'c++-mode-hook 'eglot-ensure)

;; Rust
(use-package rust-mode
  :config
  (add-to-list 'eglot-server-programs '(rust-mode . ("rls")))
  (add-hook 'rust-mode-hook 'eglot-ensure))
