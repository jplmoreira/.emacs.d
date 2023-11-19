;;; -*- lexical-binding: t; -*-

(use-package vertico
  :straight (vertico :files (:defaults "extensions/*"))
  :hook (after-init . vertico-mode)
  :general
  (jpl/leader-keys
    ";" 'vertico-repeat)
  :bind (:map vertico-map
              ("RET" . vertico-exit)
              ("C-<return>" . vertico-exit-input)
              ("C-j" . vertico-next)
              ("C-k" . vertico-previous)
              ("C-d" . vertico-scroll-up)
              ("C-u" . vertico-scroll-down))
  :config
  (add-hook 'minibuffer-setup-hook #'vertico-repeat-save)

  (defadvice vertico-insert
      (after vertico-insert-add-history activate)
    "Make vertico-insert add to the minibuffer history."
    (unless (eq minibuffer-history-variable t)
      (add-to-history minibuffer-history-variable (minibuffer-contents))))
  :custom
  (vertico-resize t)
  (vertico-count 15)
  (vertico-cycle t))

;; Configure directory extension.
(use-package vertico-directory
  :after vertico
  :ensure nil
  ;; More convenient directory navigation commands
  :bind (:map vertico-map
              ("RET" . vertico-directory-enter)
              ("C-DEL" . vertico-directory-up))
  ;; Tidy shadowed file names
  :hook (rfn-eshadow-update-overlay . vertico-directory-tidy))

(use-package mini-frame
  :straight t
  :hook (after-init . mini-frame-mode)
  :custom
  (mini-frame-show-parameters
   '((width . 0.6)
     (left . 0.5)))

  :config
  (setq resize-mini-frames t
        x-gtk-resize-child-frames 'resize-mode))

(use-package consult
  :straight t
  :bind (([remap switch-to-buffer]              . consult-buffer)
         ([remap switch-to-buffer-other-window] . consult-buffer-other-window)
         ([remap switch-to-buffer-other-frame]  . consult-buffer-other-frame)
         ([remap project-switch-to-buffer]      . consult-project-buffer)
         ([remap yank-pop]                      . consult-yank-pop)
         ([remap isearch-forward]               . consult-line)
         ([remap goto-line]                     . consult-goto-line))
  :general
  (jpl/leader-keys
    "m"  'consult-imenu
    "fg" 'consult-grep
    "fr" 'consult-ripgrep
    "fi" 'consult-git-grep
    "ff" 'consult-find
    "sl" 'consult-flymake)
  :config
  ;; Use Consult to select xref locations with preview
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)
  (consult-customize
   consult-buffer :preview-key '(:debounce 0.4 any)
   consult-ripgrep consult-git-grep consult-grep
   consult-recent-file consult-xref
   consult--source-recent-file consult--source-project-recent-file
   :preview-key "C-."))

(use-package corfu
  :straight (corfu :files (:defaults "extensions/*"))
  :hook (after-init . global-corfu-mode)
  :custom
  (corfu-auto t)
  (corfu-cycle t)
  (corfu-echo-delay 0.0)
  (corfu-popupinfo-delay '(nil . 1.0))
  :bind (:map corfu-map
              ("RET" . nil)
              ("C-j" . corfu-next)
              ("C-k" . corfu-previous)
              ("C-d" . corfu-scroll-up)
              ("C-u" . corfu-scroll-down)
              ("C-l" . corfu-popupinfo-toggle)
              ("C-;" . corfu-insert-separator))
  :config
  (setq tab-always-indent 'complete)
  (corfu-echo-mode 1)
  (corfu-indexed-mode 1)
  (corfu-popupinfo-mode 1))

(use-package nerd-icons-corfu
  :straight t
  :after corfu
  :demand t
  :config
  (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter))

(use-package orderless
  :after vertico
  :straight t
  :demand t
  :config
  (defun +orderless--consult-suffix ()
    "Regexp which matches the end of string with Consult tofu support."
    (if (and (boundp 'consult--tofu-char) (boundp 'consult--tofu-range))
        (format "[%c-%c]*$"
                consult--tofu-char
                (+ consult--tofu-char consult--tofu-range -1))
      "$"))

  ;; Recognizes the following patterns:
  ;; * .ext (file extension)
  ;; * regexp$ (regexp matching at end)
  (defun +orderless-consult-dispatch (word _index _total)
    (cond
     ;; Ensure that $ works with Consult commands, which add disambiguation suffixes
     ((string-suffix-p "$" word)
      `(orderless-regexp . ,(concat (substring word 0 -1) (+orderless--consult-suffix))))
     ;; File extensions
     ((and (or minibuffer-completing-file-name
               (derived-mode-p 'eshell-mode))
           (string-match-p "\\`\\.." word))
      `(orderless-regexp . ,(concat "\\." (substring word 1) (+orderless--consult-suffix))))))

  (defun consult--orderless-regexp-compiler (input type &rest _config)
    (setq input (orderless-pattern-compiler input))
    (cons
     (mapcar (lambda (r) (consult--convert-regexp r type)) input)
     (lambda (str) (orderless--highlight input t str))))

  (setq completion-styles '(orderless basic)
        consult--regexp-compiler #'consult--orderless-regexp-compiler
        completion-category-overrides '((file (styles basic partial-completion)))
        orderless-component-separator #'orderless-escapable-split-on-space ;; allow escaping space with backslash!
        orderless-style-dispatchers (list #'+orderless-consult-dispatch
                                          #'orderless-affix-dispatch)))

(use-package marginalia
  :straight t
  :hook (after-init . marginalia-mode)
  :bind (:map minibuffer-local-map
         ("C-o" . marginalia-cycle)))

(use-package nerd-icons-completion
  :straight t
  :after marginalia
  :demand t
  :config
  (nerd-icons-completion-mode)
  (add-hook 'marginalia-mode-hook #'nerd-icons-completion-marginalia-setup))

(use-package embark
  :straight t
  :bind (:map minibuffer-local-map
              ("C-;" . embark-act)
              ("C-l" . embark-export)
              :map embark-command-map
              ("g" . nil)
              ("l" . nil))
  :general
  (jpl/leader-keys
    "aa" 'embark-act
    "ad" 'embark-dwim)
  :custom
  (embark-mixed-indicator-delay 2))

(use-package embark-consult
  :straight t
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

;; Add prompt indicator to `completing-read-multiple'.
;; We display [CRM<separator>], e.g., [CRM,] if the separator is a comma.
;;
;; Taken from the Vertico docs.
(defun crm-indicator (args)
  (cons (format "[CRM%s] %s"
                (replace-regexp-in-string
                 "\\`\\[.*?]\\*\\|\\[.*?]\\*\\'" ""
                 crm-separator)
                (car args))
        (cdr args)))
(advice-add #'completing-read-multiple :filter-args #'crm-indicator)

(setq enable-recursive-minibuffers t)
(minibuffer-depth-indicate-mode 1)
