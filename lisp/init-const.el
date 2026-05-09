;; init-const.el --- Define constants.	-*- lexical-binding: t -*-

;; Define constants.

(defconst danis-homepage
  "https://github.com/danisramirez/.emacs.d"
  "The Github page of Danis Emacs.")

(defconst danis-custom-example-file
  (expand-file-name "custom-example.el" user-emacs-directory)
  "Custom example file of Danis Emacs.")

(defconst danis-custom-post-file
  (expand-file-name "custom-post.el" user-emacs-directory)
  "Custom file after startup.

Put private configurations to override defaults here.")

(defconst danis-env-file
  (expand-file-name "env.el" user-emacs-directory)
  "Environment file at startup.")

(defconst danis-custom-post-org-file
  (expand-file-name "custom-post.org" user-emacs-directory)
  "Custom org file after startup.

Put private configurations to override defaults here.
Loaded by `org-babel-load-file'.")

(defconst sys/win32p
  (eq system-type 'windows-nt)
  "Are we running on a WinTel system?")

(defconst sys/linuxp
  (eq system-type 'gnu/linux)
  "Are we running on a GNU/Linux system?")

(defconst sys/macp
  (eq system-type 'darwin)
  "Are we running on a Mac system?")

(defconst sys/mac-x-p
  (and (display-graphic-p) sys/macp)
  "Are we running under X on a Mac system?")

(defconst sys/mac-ns-p
  (eq window-system 'ns)
  "Are we running on a GNUstep or Macintosh Cocoa display?")

(defconst sys/mac-cocoa-p
  (featurep 'cocoa)
  "Are we running with Cocoa on a Mac system?")

(defconst sys/mac-port-p
  (eq window-system 'mac)
  "Are we running a macport build on a Mac system?")

(defconst sys/linux-x-p
  (and (display-graphic-p) sys/linuxp)
  "Are we running under X on a GNU/Linux system?")

(defconst sys/cygwinp
  (eq system-type 'cygwin)
  "Are we running on a Cygwin system?")

(defconst sys/rootp
  (string-equal "root" (getenv "USER"))
  "Are you using ROOT user?")

(defconst emacs/>=29p
  (>= emacs-major-version 29)
  "Emacs is 29 or above.")

(defconst emacs/>=29.2p
  (version<= "29.2" emacs-version)
  "Emacs is 29.2 or above.")

(defconst emacs/>=30p
  (>= emacs-major-version 30)
  "Emacs is 30 or above.")

(defconst emacs/>=31p
  (>= emacs-major-version 31)
  "Emacs is 31 or above.")

(provide 'init-const)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-const.el ends here
