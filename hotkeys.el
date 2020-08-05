(evil-leader/set-key

  ;; General
  "e" 'find-file
  "w" 'save-buffer
  "b" 'switch-to-buffer
  "kb" 'kill-buffer
  "kt" 'kill-this-buffer
  "x" 'save-buffers-kill-terminal

  ;; Anzu
  "rq" 'anzu-query-replace-regexp
  "rs" 'anzu-isearch-query-replace-regexp
  "rc" 'anzu-query-replace-at-cursor
  "rt" 'anzu-query-replace-at-cursor-thing
 
  ;; Evil nerd commenter
  "ci" 'evilnc-comment-or-uncomment-lines
  "cl" 'evilnc-quick-comment-or-uncomment-to-the-line
  "cc" 'evilnc-copy-and-comment-lines
  "cr" 'comment-or-uncomment-region

  ;; Flycheck
  "fl" 'flycheck-list-errors
  "fn" 'flycheck-next-error
  "fp" 'flycheck-previous-error

)
