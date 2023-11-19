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
