(evil-leader/set-key

  ;; General
  "e"  'find-file
  "w"  'save-buffer
  "b"  'switch-to-buffer
  "t"  'kill-this-buffer
  "q"  'save-buffers-kill-terminal
  "o"  'other-window
  "h"  'windmove-left
  "j"  'windmove-down
  "k"  'windmove-up
  "l"  'windmove-right

  ;; Anzu
  "rq" 'anzu-query-replace-regexp
  "rs" 'anzu-isearch-query-replace-regexp
  "rc" 'anzu-query-replace-at-cursor
  "rt" 'anzu-query-replace-at-cursor-thing

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

  ;; Avy
  "<SPC>" 'avy-goto-char-2
)
