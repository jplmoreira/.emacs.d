(require 'eglot)

;; C/C++
(add-to-list 'eglot-server-programs '((c++-mode c-mode) . ("clangd")))
(add-hook 'c-mode-hook 'eglot-ensure)
(add-hook 'c++-mode-hook 'eglot-ensure)

;; Rust
(use-package rust-mode
  :config
  (add-to-list 'eglot-server-programs '(rust-mode . ("rust-analyzer")))
  (add-hook 'rust-mode-hook 'eglot-ensure))

;; Dockerfile
(use-package dockerfile-mode
  :init
  (add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode)))

(use-package yaml-mode
  :init
  (add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode)))
