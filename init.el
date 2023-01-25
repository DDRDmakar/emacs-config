;;-------------------------------------
;; Nikita Makarevich (DDRDmakar) 2021,2022
;; makarevich.98@mail.ru
;;-------------------------------------

;; Speed-up startup time
;; 50 MiB before GC is invoked
(setq gc-cons-threshold (* 50 1024 1024))

;;==================================[ Custom functions ]====================================
(defconst user-init-dir
  (cond ((boundp 'user-emacs-directory)
         user-emacs-directory)
        ((boundp 'user-init-directory)
         user-init-directory)
        (t "~/.emacs.d/")))

(defun load-user-file (file)
  "Load a file in current user's configuration directory"
  (interactive "f")
  (load-file (expand-file-name file user-init-dir)))

(defun create-if-not-exists (filePath)
  (unless (file-exists-p filePath)
    (with-temp-buffer (write-file filePath))))

;; Display file name command
(defun show-file-name ()
  "Show the full path file name in the minibuffer."
  (interactive)
  (message (buffer-file-name)))

;;==================================[ Load system-specific config ]====================================
(load-user-file "system-specific.el")

;; Custom set variables
(setq custom-file (expand-file-name "custom.el" user-init-dir))
(create-if-not-exists custom-file)

;;==================================[ Packages ]====================================

;; Uncomment it if you have problems downloading packages
;;(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

;; Tell emacs where is your personal elisp lib dir
(add-to-list 'load-path (expand-file-name "lisp" user-init-dir))

(require 'package)
(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ("elpa"  . "https://elpa.gnu.org/packages/")
        ;;("gnu-devel"  . "https://elpa.gnu.org/devel/")
        ("org"   . "https://orgmode.org/elpa/"))
      )
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)

(setq use-package-always-ensure t)

;; Keep packages up-to-date
(use-package auto-package-update
  :if ded/auto-package-update
  :custom
  (auto-package-update-interval 7)
  (auto-package-update-prompt-before-update t)
  (auto-package-update-hide-results nil)
  :config
  (auto-package-update-maybe)
  ;;(auto-package-update-at-time "09:00")
  )

;;==================================[ Load other config parts ]====================================

(load-user-file "easykey.el")
(load-user-file "other.el")
(load-user-file "org.el")
(load-user-file "hdl.el")
(load-user-file "visual.el")
(load-user-file "addition.el")

(load-user-file "variables.el") ;; Should be executed after loading all modules

;;==================================[ Load custom variables ]====================================
(load custom-file)

;;=============================================================================
;;==================================[ End ]====================================
;;=============================================================================
