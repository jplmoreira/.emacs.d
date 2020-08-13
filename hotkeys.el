(load "~/.emacs.d/move-border.el")

(evil-leader/set-key

  ;; General
  "e"  'find-file
  "w"  'save-buffer
  "b"  'switch-to-buffer
  "d"  'kill-this-buffer
  "q"  'save-buffers-kill-terminal
  "o"  'other-window
  "h"  'windmove-left
  "j"  'windmove-down
  "k"  'windmove-up
  "l"  'windmove-right
  "H"  'move-border-left
  "J"  'move-border-down
  "K"  'move-border-up
  "L"  'move-border-right

  ;; Evil numbers
  "+"  'evil-numbers/inc-at-pt
  "-"  'evil-numbers/dec-at-pt

  ;; Evil args
  "al" 'evil-forward-arg
  "ah" 'evil-backward-arg
  "aj" 'evil-jump-out-args

  ;; Evil nerd commenter
  "ci" 'evilnc-comment-or-uncomment-lines
  "ct" 'evilnc-comment-or-uncomment-to-the-line
  "cl" 'evilnc-comment-operator
  "cc" 'evilnc-copy-and-comment-operator

  ;; Anzu
  "rq" 'anzu-query-replace-regexp
  "rs" 'anzu-isearch-query-replace-regexp
  "rc" 'anzu-query-replace-at-cursor
  "rt" 'anzu-query-replace-at-cursor-thing

  ;; Avy
  "v"  'avy-goto-char-2

  ;; Ivy
  ";"  'ivy-resume
  "z"  'prot/counsel-fzf-rg-files
  "x"  'counsel-rg

  ;; eglot
  "sc" 'eglot-reconnect
  "ss" 'eglot-shutdown
  "sr" 'eglot-rename
  "sf" 'eglot-format
  "sa" 'eglot-code-actions
  "sh" 'eglot-help-at-point
  "sd" 'eglot-find-declaration
  "si" 'eglot-find-implementation
  "st" 'eglot-find-typeDefinition
  "se" 'xref-find-references
  "sp" 'xref-apropos
  "sj" 'flymake-goto-next-error
  "sk" 'flymake-goto-prev-error
  "sg" 'flymake-show-diagnostics-buffer

  ;; Treemacs
  "<SPC>" 'treemacs-select-window
  "to"    'treemacs-delete-other-windows

)
