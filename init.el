;;; init.el --- A Fancy and Fast Emacs Configuration.	-*- lexical-binding: t no-byte-compile: t -*-


;;; Code:

(when (version< emacs-version "28.1")
  (error "This requires Emacs 28.1 and above!"))

;;
;; Speed up Startup Process
;;

;; Optimize `auto-mode-alist'
(setq auto-mode-case-fold nil)

;; PERF: Restore file-name-handler-alist after startup.
;; It was set to nil in early-init.el for faster startup.
(unless (or (daemonp) noninteractive init-file-debug)
  (add-hook 'emacs-startup-hook
            (lambda ()
              (setq file-name-handler-alist
                    (delete-dups (append file-name-handler-alist
                                         danis--file-name-handler-alist))))
            101))

;;
;; Configure Load Path
;;

;; Add "lisp" and "site-lisp" to the beginning of `load-path`
(defun update-load-path (&rest _)
  "Update the `load-path` to prioritize personal configurations."
  (dolist (dir '("site-lisp" "lisp"))
    (push (expand-file-name dir user-emacs-directory) load-path)))

;; Initialize load paths explicitly
(update-load-path)

;; Add subdirectories inside "site-lisp" to `load-path`
(defun add-subdirs-to-load-path (&rest _)
  "Recursively add subdirectories in `site-lisp` to `load-path`.

Avoid placing large files like EAF in `site-lisp` to prevent slow startup."
  (let ((default-directory (expand-file-name "site-lisp" user-emacs-directory)))
    (normal-top-level-add-subdirs-to-load-path)))

;; Ensure these functions are called after `package-initialize`
(advice-add #'package-initialize :after #'add-subdirs-to-load-path)

;; Requisites
(require 'init-const)
(require 'init-custom)
(require 'init-funcs)

;; Packages
(require 'init-package)

;; Preferences
(require 'init-base)
(require 'init-hydra)
(require 'init-ui)
(require 'init-dashboard)
(require 'init-edit)
(require 'init-completion)
(require 'init-dired)
(require 'init-highlight)
(require 'init-ibuffer)
(require 'init-workspace)
(require 'init-utils)

(require 'init-org)
;; Programming


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init.el ends here
