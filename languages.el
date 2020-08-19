(use-package eglot
  :pin gnu
  :config
  ;; C/C++
  (add-to-list 'eglot-server-programs '((c++-mode c-mode) . ("clangd")))
  (add-hook 'c-mode-hook 'eglot-ensure)
  (add-hook 'c++-mode-hook 'eglot-ensure))

;; Rust
(use-package rust-mode
  :defer t
  :config
  (add-to-list 'eglot-server-programs '(rust-mode . ("rust-analyzer")))
  (add-hook 'rust-mode-hook 'eglot-ensure))

;; Dockerfile
(use-package dockerfile-mode
  :defer t
  :init
  (add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode)))

(use-package yaml-mode
  :defer t
  :init
  (add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode)))
