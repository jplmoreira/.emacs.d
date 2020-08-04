
(evil-leader/set-key
  "e" 'counsel-find-file
  "w" 'save-buffer
  "r" 'eval-buffer
  "b" 'switch-to-buffer
  "kb" 'kill-buffer
  "kt" 'kill-this-buffer
  "x" 'save-buffers-kill-terminal
  "ci" 'evilnc-comment-or-uncomment-lines
  "cl" 'evilnc-quick-comment-or-uncomment-to-the-line
  "cc" 'evilnc-copy-and-comment-lines
  "cr" 'comment-or-uncomment-region
  "fl" 'flycheck-list-errors
  "fn" 'flycheck-next-error
  "fp" 'flycheck-previous-error)
