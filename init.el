(setq user-full-name "João Moreira"
      user-mail-address "jplmoreira@tecnico.pt")

(setq gc-cons-threshold 50000000
	  large-file-warning-threshold 100000000)

(add-to-list 'default-frame-alist '(fullscreen . maximized))
(tool-bar-mode -1)
(unless (eq system-type 'darwin)
  (menu-bar-mode -1))
(scroll-bar-mode -1)
(electric-pair-mode t) (show-paren-mode t)
(set-face-attribute 'show-paren-match t :weight 'extra-bold)
(global-hl-line-mode t)
(column-number-mode t)
(size-indication-mode t)
(setq inhibit-startup-screen t)
(fset 'yes-or-no-p 'y-or-n-p)
(set-default 'truncate-lines t)
(setq-default ident-tabs-mode nil)
(setq-default tab-width 4)
(setq ident-line-function 'insert-tab)

(setq-default display-line-numbers 'relative
			  display-line-numbers-type 'visual
              display-line-numbers-current-absolute t
			  display-line-numbers-width 3
              display-line-numbers-widen t)
(add-hook 'text-mode-hook #'display-line-numbers-mode)

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
						 ("melpa-stable" . "http://stable.melpa.org/packages/")
						 ("marmalade" . "http://marmalade-repo.org/packages/")
						 ("melpa" . "http://melpa.org/packages/")
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

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package whitespace
  :init
  (setq whitespace-style '(face empty tabs lines-tail trailing))
  :config
  (global-whitespace-mode t))

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
  (evil-mode t))

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
  (evil-snipe-mode t)
  (evil-snipe-override-mode t)
  :custom
  (evil-snipe-scope 'visible)
  (evil-snipe-repeat-scope 'whole-visible))

(use-package evil-numbers)
(use-package evil-matchit)
(use-package evil-anzu)

(use-package avy
  :init
  (setq avy-all-windows t))

(use-package ivy
  :init
  (ivy-mode t)
  :bind (:map ivy-minibuffer-map
		 ("RET" . ivy-alt-done)
		 ("C-<return>" . ivy-immediate-done)
		 ("C-j" . ivy-next-line)
		 ("C-k" . ivy-previous-line)
		 ("C-u" . ivy-scroll-down-command)
		 ("C-d" . ivy-scroll-up-command))
  :custom
  (ivy-wrap t)
  (ivy-use-virtual-buffers t)
  (ivy-count-format "(%d/%d) "))

(use-package amx
  :after ivy
  :custom
  (amx-backend 'auto)
  :config
  (amx-mode t))

(use-package counsel
  :after (ivy amx)
  :init (counsel-mode t)
  :config
  (defun prot/counsel-fzf-rg-files (&optional input dir)
	"Run `fzf' in tandem with `ripgrep' to find files in the
	 present directory.  If invoked from inside a version-controlled
	 repository, then the corresponding root is used instead."
	(interactive)
	(let* ((process-environment
			(cons (concat "FZF_DEFAULT_COMMAND=rg -Sn --color never --files --no-follow --hidden")
				  process-environment))
		   (vc (vc-root-dir)))
	  (if dir
		  (counsel-fzf input dir)
		(if (eq vc nil)
			(counsel-fzf input default-directory)
		  (counsel-fzf input vc)))))

  (defun prot/counsel-fzf-dir (arg)
	"Specify root directory for `counsel-fzf'."
	(prot/counsel-fzf-rg-files ivy-text
							   (read-directory-name
								(concat (car (split-string counsel-fzf-cmd))
										" in directory: "))))

  (defun prot/counsel-rg-dir (arg)
	"Specify root directory for `counsel-rg'."
	(let ((current-prefix-arg '(4)))
	  (counsel-rg ivy-text nil "")))

  (ivy-add-actions
   'counsel-fzf
   '(("r" prot/counsel-fzf-dir "change root directory")
	 ("g" prot/counsel-rg-dir "use ripgrep in root directory")))

  (ivy-add-actions
   'counsel-rg
   '(("r" prot/counsel-rg-dir "change root directory")
	 ("z" prot/counsel-fzf-dir "find file with fzf in root directory")))

  (ivy-add-actions
   'counsel-find-file
   '(("g" prot/counsel-rg-dir "use ripgrep in root directory")
	 ("z" prot/counsel-fzf-dir "find file with fzf in root directory"))))

(use-package swiper
  :after counsel
  :bind ("C-s" . 'swiper-isearch))

(use-package ivy-posframe
  :after ivy
  :custom
  (ivy-posframe-display-functions-alist
   '((t . ivy-posframe-display-at-frame-top-center)))
  :config
  (ivy-posframe-mode t)
  (defun ivy-posframe-get-size ()
	"The default functon used by `ivy-posframe-size-function'."
	(list
	 :height ivy-posframe-height
	 :width ivy-posframe-width
	 :min-height (or ivy-posframe-min-height
					 (let ((height (+ ivy-height 1)))
					   (min height (or ivy-posframe-height height))))
	 :min-width (or ivy-posframe-min-width
					(let ((width (round (* (frame-width) 0.75))))
					  (min width (or ivy-posframe-width width)))))))

(use-package prescient
  :custom
  (prescient-history-length 200)
  (prescient-save-file "~/.emacs.d/prescient-items")
  (prescient-filter-method '(literal regexp))
  :config
  (prescient-persist-mode t))

(use-package ivy-prescient
  :after (counsel prescient)
  :config
  (ivy-prescient-mode))

(use-package all-the-icons-ivy-rich
  :init
  (all-the-icons-ivy-rich-mode t)
  :custom
  (all-the-icons-ivy-rich-icon-size 0.8))

(use-package ivy-rich
  :after all-the-icons-ivy-rich
  :init
  (ivy-rich-mode t))

(setq package-pinned-packages
	  '((eglot . "gnu")))
(unless (package-installed-p 'eglot)
	(package-refresh-contents)
	(package-install 'eglot))
(load "~/.emacs.d/languages")

(use-package company
  :hook
  (prog-mode . company-mode)
  :custom
  (company-idle-delay 0)
  (company-minimum-prefix-length 1)
  (company-tooltip-align-annotations t)
  (company-tooltip-limit 10)
  (company-require-match 'never)
  (company-show-numbers t)
  :bind (:map company-active-map
		 ("C-j" . company-select-next)
		 ("C-k" . company-select-previous)
		 ("<tab>" . company-complete-common)
		 ("RET" . company-complete-selection)))

(load "~/.emacs.d/hotkeys")
