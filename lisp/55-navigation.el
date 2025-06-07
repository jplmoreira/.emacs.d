;;; -*- lexical-binding: t; -*-

(use-package avy
  :straight t
  :general
  (jpl/leader-keys
    "v" 'avy-goto-char-2))

(use-package treemacs
  :straight t
  :general
  (jpl/leader-keys
    :keymaps 'override
    "<SPC>"  'treemacs-select-window
    :keymaps 'treemacs-mode-map
    "to"     'treemacs-delete-other-windows)
  (:keymaps 'treemacs-mode-map
            :states 'treemacs
            "gw"  'treemacs-set-width
            "pa"  'treemacs-add-project-to-workspace
            "pd"  'treemacs-remove-project-from-workspace
            "pr"  'treemacs-rename-project
            "pn"  'treemacs-next-project
            "pp"  'treemacs-previous-project
            "pcc" 'treemacs-collapse-project
            "pco" 'treemacs-collapse-all-projects
            "wr"  'treemacs-rename-workspacea
            "wa"  'treemacs-create-workspace
            "wd"  'treemacs-remove-workspace
            "ws"  'treemacs-switch-workspace
            "we"  'treemacs-edit-workspaces
            "wn"  'treemacs-next-workspace
            "wf"  'treemacs-set-fallback-workspace)

  :custom
  (treemacs-is-never-other-window t)
  (treemacs-collapse-dirs 10)
  :config
  (treemacs-git-mode 'simple)
  (treemacs-filewatch-mode t))

(use-package treemacs-evil
  :after (evil treemacs)
  :straight t
  :demand t)

(use-package treemacs-nerd-icons
  :after treemacs
  :straight t
  :demand t
  :config
  (treemacs-load-theme "nerd-icons"))

(use-package magit
  :straight t
  :general
  (jpl/leader-keys
    "gg" 'magit-status
    "gd" 'magit-dispatch
    "gf" 'magit-file-dispatch)
  :custom
  (magit-display-buffer-function
   #'magit-display-buffer-fullframe-status-v1))

(use-package treemacs-magit
  :after treemacs
  :straight t
  :demand t)
