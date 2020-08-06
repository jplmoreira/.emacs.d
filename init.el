(setq user-full-name "João Moreira"
      user-mail-address "jplmoreira@tecnico.pt")

(setq gc-cons-threshold 50000000
	  large-file-warning-threshold 100000000)

(add-to-list 'default-frame-alist '(fullscreen . maximized))
(tool-bar-mode -1)
(unless (eq system-type 'darwin)
  (menu-bar-mode -1))
(scroll-bar-mode -1)
(electric-pair-mode t)
(show-paren-mode t)
(set-face-attribute 'show-paren-match t :weight 'extra-bold)
(global-hl-line-mode t)
(column-number-mode t)
(size-indication-mode t)
(setq inhibit-startup-screen t)
(fset 'yes-or-no-p 'y-or-n-p)
(set-default 'truncate-lines t)
(setq-default ident-tabs-mode nil)
(setq-default tab-width 4)

(when (eq system-type 'darwin)
  (global-set-key [kp-delete] 'delete-char)
  (setq mac-option-modifier 'alt
	mac-command-modifier 'meta
	mac-right-command-modifier nil
	mac-right-option-modifier nil
	select-enable-clipboard t
	ns-use-native-fullscreen t))

(setq custom-file "~/.emacs.d/garbage.el")

(make-directory "~/.emacs.d/autosaves/" t)
(setq auto-save-file-name-transforms
      `(("\\(?:[^/]*/\\)*\\(.*\\)" "~/.emacs.d/autosaves/\\1" t)))
(make-directory "~/.emacs.d/backups/" t)
(setq backup-directory-alist `(("." . "~/.emacs.d/backups/")))
(setq create-lockfiles nil
	  backup-by-copying t
	  version-control t
	  delete-old-versions t)

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
						 ("elpa" . "http://tromey.com/elpa/")
						 ("melpa" . "http://melpa.org/packages/")
						 ("melpa-stable" . "http://stable.melpa.org/packages/")
						 ("marmalade" . "http://marmalade-repo.org/packages/")
						 ("org" . "http://orgmode.org/elpa/")))

;; Setup package.el
(require 'package)
(setq package-enable-at-startup nil)
(package-initialize)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package-ensure)
(setq use-package-always-ensure t)
(setq use-package-verbose t)

(when (member "mononoki" (font-family-list))
  (set-frame-font "mononoki" nil t)
  (set-face-attribute 'default nil :height 130))

(use-package doom-themes
  :config
  (load-theme 'doom-palenight t))

(use-package doom-modeline
  :hook (after-init . doom-modeline-init))

(use-package solaire-mode
  :config
  (solaire-global-mode))

(setq evil-want-integration t
	  evil-want-C-i-jump nil
	  evil-want-C-u-scroll t
	  evil-want-keybinding nil)

(use-package evil-leader
  :init
  (global-evil-leader-mode)
  (evil-leader/set-leader "<SPC>"))

(use-package evil-collection
  :after evil-leader
  :init
  (evil-collection-init))

(use-package evil
  :after evil-collection
  :config
  (evil-mode 1))

(use-package evil-surround
  :config
  (global-evil-surround-mode))

(use-package evil-nerd-commenter
  :config
  (evilnc-toggle-invert-comment-line-by-line))

(use-package evil-exchange
  :config
  (evil-exchange-install))

(use-package evil-args
  :bind (:map evil-inner-text-objects-map
		 ("a" . evil-inner-arg)
		 :map evil-outer-text-objects-map
		 ("a" . evil-outer-arg)))

(use-package evil-snipe
  :config
  (evil-snipe-mode 1)
  (evil-snipe-override-mode 1)
  :custom
  (evil-snipe-scope 'visible)
  (evil-snipe-repeat-scope 'whole-visible))

(use-package evil-numbers)
(use-package evil-matchit)
(use-package evil-anzu)

(load "~/.emacs.d/hotkeys")
