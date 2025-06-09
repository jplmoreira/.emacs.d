;;; -*- lexical-binding: t; -*-

(use-package general
  :straight t
  :demand t
  :config
  (general-evil-setup)
  (general-create-definer jpl/leader-keys
    :states '(normal insert visual emacs treemacs)
    :prefix "SPC"
    :global-prefix "C-SPC")

  (jpl/leader-keys
    "w"  'save-buffer
    "q"  'save-buffers-kill-terminal
    "o"  'other-window
    "h"  'windmove-left
    "j"  'windmove-down
    "k"  'windmove-up
    "l"  'windmove-right
    "e"  'find-file
    "b"  'switch-to-buffer
    "db" 'kill-current-buffer
    "do" 'delete-other-windows
    "dd" 'kill-buffer-and-window))

(use-package evil
  :straight t
  :hook (after-init . evil-mode)
  :custom
  (evil-want-integration t)
  (evil-want-C-i-jump nil)
  (evil-want-C-u-scroll t)
  (evil-want-keybinding nil)
  :config
  (setq evil-normal-state-cursor '(hbar . 3)))

(use-package evil-collection
  :after evil
  :straight t
  :demand t
  :config
  (evil-collection-init))

(use-package evil-surround
  :after evil
  :straight t
  :demand t
  :config
  (global-evil-surround-mode 1))

(use-package evil-commentary
  :after evil
  :straight t
  :demand t
  :config
  (evil-commentary-mode))

(use-package evil-matchit
  :after evil
  :straight t
  :hook
  (prog-mode . turn-on-evil-matchit-mode))
