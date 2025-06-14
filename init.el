;;; -*- lexical-binding: t; -*-

;; Load early-init.el regardless of the way Emacs was started.
(require 'early-init (expand-file-name "early-init" user-emacs-directory))

;; Load no-littering.el before anything else to keep ~/.emacs.d/ tidy.
(use-package no-littering
  :straight t
  :demand t
  :config
  (no-littering-theme-backups))

;; Expose the packages integrated into the config repository.
(add-to-list 'load-path (expand-file-name "vendor/" user-emacs-directory))

;; Load the machine-local custom.el, versioned separately.
;; Possibly absent.
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file 'noerror)


;; Load the config management and maintenance helper library.
(require 'config-lib (expand-file-name "config-lib" user-emacs-directory))

;; Load all the config parts.
(load-numbered-parts (expand-file-name "lisp/" user-emacs-directory))

;; Load the machine-local config parts.
(unless (getenv "EMACS_NO_LOCAL")
  ;; Load ~/.emacs.d/local.el
  (let ((local-lisp (expand-file-name "local" user-emacs-directory)))
    (load local-lisp 'noerror))
  ;; Load ~/.emacs.d/local.d/*.el
  (let ((local-lisps (expand-file-name "local.d/" user-emacs-directory)))
    (when (file-directory-p local-lisps)
      (load-parts local-lisps))))

;; Load the defered config parts for CI runs.
(when (getenv "EMACS_FORCE_EAGER")
  (load-defered))
