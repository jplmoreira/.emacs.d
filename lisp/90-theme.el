;;; -*- lexical-binding: t; -*-

;; Set custom font
(cond

 ((member "mononoki" (font-family-list))
  (set-frame-font "mononoki 13" nil t))

 ((member "iosevka" (font-family-list))
  (set-frame-font "iosevka 11" nil t))

 ((member "Cascadia Code PL" (font-family-list))
  (set-frame-font "Cascadia Code PL 11" nil t))
 )

(use-package doom-modeline
  :straight t
  :hook (after-init . doom-modeline-mode))

(use-package catppuccin-theme
  :after doom-modeline
  :straight t
  :demand t
  :config
  (load-theme 'catppuccin :no-confirm)

  (set-face-attribute 'show-paren-match nil
                      :weight 'bold
                      :foreground (face-background 'default)
                      :background (face-foreground 'warning)))

(use-package solaire-mode
  :after catppuccin-theme
  :straight t
  :demand t
  :config
  (solaire-global-mode))
