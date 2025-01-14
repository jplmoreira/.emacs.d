;;; -*- lexical-binding: t; -*-

(use-package savehist
  :demand t
  :ensure nil
  :config
  (savehist-mode t))

(use-package recentf
  :demand t
  :ensure nil
  :config
  (recentf-mode t)
  (run-at-time nil 600 'recentf-save-list)
  (add-to-list 'recentf-exclude
               (recentf-expand-file-name no-littering-var-directory))
  (add-to-list 'recentf-exclude
               (recentf-expand-file-name no-littering-etc-directory)))

(use-package wgrep :straight t :demand t)

(use-package exec-path-from-shell
  :straight t
  :config
  (setq exec-path-from-shell-debug t)
  (add-to-list 'exec-path-from-shell-variables "SSH_AUTH_SOCK")
  (add-to-list 'exec-path-from-shell-variables "GPG_TTY")
  (exec-path-from-shell-initialize))
