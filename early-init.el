;;; early-init.el --- Early initialization. -*- lexical-binding: t -*-


;; PERF: Defer garbage collection further back in the startup process.
;; `gcmh-mode' (in init-base.el) will restore this after startup.
(if noninteractive  ; in CLI sessions
    (setq gc-cons-threshold #x8000000   ; 128MB
          ;; Backport from 29 (see emacs-mirror/emacs@73a384a98698)
          gc-cons-percentage 1.0)
  (setq gc-cons-threshold most-positive-fixnum))

;; PERF: Many elisp file API calls consult `file-name-handler-alist'.
;; Setting it to nil speeds up startup significantly.
;; We restore it in init.el after startup.
(defvar danis--file-name-handler-alist file-name-handler-alist)
(setq file-name-handler-alist nil)

;; Prevent unwanted runtime compilation for gccemacs (native-comp) users;
;; packages are compiled ahead-of-time when they are installed and site files
;; are compiled when gccemacs is installed.
(setq native-comp-deferred-compilation nil ;; obsolete since 29.1
      native-comp-jit-compilation nil)

;; PERF: Reduce file-name operations on `load-path'.
;; No dynamic modules are loaded this early, so we skip .so/.dll search.
;; Also skip .gz to avoid decompression checks.
(setq load-suffixes '(".elc" ".el")
      load-file-rep-suffixes '(""))

;; Package initialize occurs automatically, before `user-init-file' is
;; loaded, but after `early-init-file'. We handle package
;; initialization, so we must prevent Emacs from doing it early!
(setq package-enable-at-startup nil)

;; `use-package' is builtin since 29.
;; It must be set before loading `use-package'.
(setq use-package-enable-imenu-support t)

;; In noninteractive sessions, prioritize non-byte-compiled source files to
;; prevent the use of stale byte-code. Otherwise, it saves us a little IO time
;; to skip the mtime checks on every *.elc file.
(setq load-prefer-newer noninteractive)

;; Explicitly set the preferred coding systems to avoid annoying prompt
;; from emacs (especially on Microsoft Windows)
(prefer-coding-system 'utf-8)

;; Inhibit resizing frame
(setq frame-inhibit-implied-resize t)

;; Faster to disable these here (before they've been initialized)
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)
(when (featurep 'ns)
  (push '(ns-transparent-titlebar . t) default-frame-alist)
  (push '(ns-appearance . dark) default-frame-alist))

;; Prevent flash of unstyled mode line
(setq-default mode-line-format nil)

;; PATH and other environment variables injection
;; To avoid loading `exec-path-from-shell' for better performance
(when-let ((env-file (expand-file-name "env.el" user-emacs-directory))
           (env-example-file (expand-file-name "env-example.el" user-emacs-directory)))
  (when (and (not (file-exists-p env-file))
             (file-exists-p env-example-file))
    (copy-file env-example-file env-file))
  (load env-file 'noerror))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; early-init.el ends here
