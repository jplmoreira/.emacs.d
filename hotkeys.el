(evil-leader/set-key

  ;; General
  "e"  'find-file
  "w"  'save-buffer
  "b"  'switch-to-buffer
  "kb" 'kill-buffer
  "kt" 'kill-this-buffer
  "x"  'save-buffers-kill-terminal

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
 
  ;; Evil nerd commenter
  "ci" 'evilnc-comment-or-uncomment-lines
  "ct" 'evilnc-comment-or-uncomment-to-the-line
  "cl" 'evilnc-comment-operator
  "cc" 'evilnc-copy-and-comment-operator

  ;; Flycheck
  "fl" 'flycheck-list-errors
  "fn" 'flycheck-next-error
  "fp" 'flycheck-previous-error

)
