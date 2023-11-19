;;; config-lib.el --- Facilities for loading the rest of my config.  -*- lexical-binding: t; -*-

;; Author: Wojciech Siewierski
;; Keywords: lisp, maint, local

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; Facilities for loading and maintaining the rest of my config.

;;; Code:

;;;###autoload
(defun load-parts (directory &optional regexp recursive)
  "Load all the Elisp files from DIRECTORY, in the lexicographical order.

REGEXP defaults to `load-parts--regexp'.

If RECURSIVE is non-nil, load files recursively, sorted by their
full paths.

Inspired by: https://manpages.debian.org/stable/debianutils/run-parts.8.en.html"
  (interactive "D")
  (dolist (part (load-parts--gather directory regexp recursive))
    (load part)))

(defun require-parts (directory &optional regexp recursive)
  "The same as `load-parts' but uses `require' instead of `load'.

Should be used instead `load-parts' if loading a feature multiple
times is a concern.

If RECURSIVE is non-nil, require files recursively, sorted by
their full paths."
  (dolist (part (load-parts--gather directory regexp recursive))
    (require (intern (file-name-nondirectory part))
             part)))

(defconst load-parts--regexp
  (rx string-start
      (not ".")
      (zero-or-more any)
      ".el"
      (opt "c")
      string-end)
  "A regexp matching *.el and *.elc files, but not dotfiles.")

(defun load-parts--gather (directory &optional regexp recursive)
  "Gather the files from DIRECTORY for `load-parts'.

REGEXP defaults to `load-parts--regexp'.

If RECURSIVE is non-nil, gather files recursively, sorted by
their full paths.  Skips directories starting with a dot."
  (setq regexp (or regexp "\\`[^.].*\\.elc?\\'"))
  (delete-dups
   (mapcar #'file-name-sans-extension
           (if recursive
               (sort (directory-files-recursively
                      (file-name-as-directory directory) regexp
                      nil
                      (lambda (dir)
                        ;; Omit directories starting with a dot.
                        (not (string-match-p
                              "\\`\\."
                              (file-name-nondirectory dir)))))
                     #'string<)
             (directory-files (file-name-as-directory directory)
                              t regexp)))))

(defconst load-numbered-parts--regexp
  (rx string-start
      (= 2 digit)
      "-"
      (one-or-more any)
      ".el"
      (opt "c")
      string-end)
  "A regexp matching files like 10-name.el")

(defun load-numbered-parts (directory &optional max)
  "Load numbered config parts from DIRECTORY.

Optionally load only the parts up to the MAX numbered part (inclusive)."
  (dolist (part (load-parts--gather directory load-numbered-parts--regexp))
    (if (null max)
        (load part)
      (let* ((part-name (file-name-nondirectory part))
             (part-number-as-string (substring part-name 0 2))
             (part-number (string-to-number part-number-as-string)))
        (when (<= part-number max)
          (load part))))))

(defun load-defered ()
  "Forcefully load every `eval-after-load' block.

Mostly useful for continuous integration and pre-commit hooks."
  (require 'find-func)
  (dolist (pkg (mapcar #'car after-load-alist))
    (when (and (symbolp pkg)
               (ignore-error 'file-error
                 (find-library-name (symbol-name pkg))))
      (require pkg))))

(defun check-autoloads (&optional known-broken)
  "Forcefully load every autoloaded function.

This operation is expected to fail most of the time, even on
a vanilla Emacs installation.  For this reason no errors are
signalled, displaying warnings instead for the user to
analyze manually.

Returns a list of the most likely broken autoloads.  This is
defined as their loading not signaling any errors but still
failing to define the autoloaded function.  Symbols within the
KNOWN-BROKEN list are omitted from the result (but the warnings
are still emitted)."
  (let (failed-autoloads)
    (mapatoms
     (lambda (ob)
	   (let ((func (symbol-function ob)))
	     (when (autoloadp func)
           (condition-case err
               (autoload-do-load func)
             (error
              (warn "Error during loading the autoload `%S': %S" ob err))
             (:success
              ;; Check whether the loaded file actually defined the
              ;; autoloaded function.  If not, display a warning.
              (when (autoloadp (symbol-function ob))
                (unless (memq ob known-broken)
                  (push ob failed-autoloads))
                (warn "Failed to autoload `%S' despite no errors" ob))))))))
    failed-autoloads))

(defcustom autoloads-known-broken nil
  "Known broken autoloads to omit from `autoloads-report'."
  :type '(repeat symbol))

;;;###autoload
(defun autoloads-report (&optional check-all)
  "Forcefully load every autoloaded function and report possible issues.

See: `check-autoloads'

Unless CHECK-ALL (\\[universal-argument]) is non-nil,
`autoloads-known-broken' is passed to `check-autoloads' as
its argument."
  (interactive "P")
  (with-current-buffer (get-buffer-create "*Autoload Report*")
    (special-mode)
    (let* ((inhibit-read-only t)
           (known-broken (unless check-all
                           autoloads-known-broken))
           (failed-autoloads (check-autoloads known-broken)))
      (erase-buffer)
      (if failed-autoloads
          (progn
            (insert "Possibly broken autoloads:\n\n")
            (insert (mapconcat (lambda (ob)
                                 (format "  %S\n" ob))
                               failed-autoloads)))
        (insert "No broken autoloads detected.\n"))
      (when known-broken
        (insert "\nExcluded symbols:\n\n")
        (insert (mapconcat (lambda (ob)
                             (format "  %S\n" ob))
                           known-broken)))
      (goto-char (point-min))
      (pop-to-buffer-same-window (current-buffer)))))

(provide 'config-lib)
;;; config-lib.el ends here
