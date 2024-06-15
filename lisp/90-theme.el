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

(use-package doom-themes
  :after doom-modeline
  :straight t
  :demand t
  :config
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t)
  (load-theme 'doom-tomorrow-night t)

  (set-face-attribute 'show-paren-match nil
                      :weight 'bold
                      :foreground (face-background 'default)
                      :background (face-foreground 'warning)))

(use-package solaire-mode
  :after doom-themes
  :straight t
  :demand t
  :config
  (solaire-global-mode))
