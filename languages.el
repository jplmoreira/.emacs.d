(use-package eglot
  :pin gnu
  :config
  ;; C/C++
  (add-to-list 'eglot-server-programs '((c++-mode c-mode) . ("clangd")))
  (add-hook 'c-mode-hook 'eglot-ensure)
  (add-hook 'c++-mode-hook 'eglot-ensure)
  (add-to-list 'eglot-server-programs
               '(sh-mode . ("bash-language-server" "start")))
  (setq-default sh-indentation 2)
  (add-hook 'sh-mode-hook 'eglot-ensure))

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

;; YAML
(use-package yaml-mode
  :defer t
  :init
  (add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode)))

;; Go
(use-package go-mode
  :defer t
  :config
  (add-to-list 'auto-mode-alist '("\\.go\\'" . go-mode))
  (add-to-list 'eglot-server-programs '(go-mode . ("gopls")))
  (add-hook 'go-mode-hook 'eglot-ensure))

;; Typescript
(use-package typescript-mode
  :defer t
  :config
  (setq-default typescript-indent-level 2)
  (add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-mode))
  (add-to-list 'eglot-server-programs
               '(typescript-mode . ("typescript-language-server" "--stdio")))
  (add-hook 'typescript-mode-hook 'eglot-ensure))
