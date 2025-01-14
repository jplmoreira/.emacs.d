;;; -*- lexical-binding: t; -*-

(global-subword-mode 1)
(diminish 'subword-mode)

(show-paren-mode t)
(electric-pair-mode t)
(global-hl-line-mode t)
(global-auto-revert-mode 1)
(setq delete-pair-blink-delay 0)
(setq parens-require-spaces nil)

(column-number-mode t)
(size-indication-mode t)

(setq inhibit-startup-screen t)
(setq initial-major-mode 'fundamental-mode)

(fset 'yes-or-no-p 'y-or-n-p)
(setq y-or-n-p-use-read-key t)

(blink-cursor-mode 0)
(setq visible-cursor nil)
(setq echo-keystrokes 0.1)

(setq require-final-newline t)
(set-default 'truncate-lines t)
(setq-default indicate-buffer-boundaries 'left)

;; Indentation
(setq-default indent-tabs-mode nil)
(setq ident-line-function 'insert-tab)
(setq-default standard-indent 2)
(setq-default default-tab-width 4
              tab-width 4
              c-basic-indent 4
              c-basic-offset 4
              sh-indentation 4)

;; Display line config
(setq-default display-line-numbers 'relative
              display-line-numbers-type 'visual
              display-line-numbers-current-absolute t
              display-line-numbers-width 3
              display-line-numbers-widen t)
(add-hook 'text-mode-hook #'display-line-numbers-mode)

;; macOS specific config
(when (eq system-type 'darwin)
  (global-set-key [kp-delete] 'delete-char)
  (setq mac-option-modifier 'alt
        mac-command-modifier 'meta
        mac-right-command-modifier nil
        mac-right-option-modifier nil
        select-enable-clipboard t
        ns-use-native-fullscreen t))
