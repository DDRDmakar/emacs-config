;;-------------------------------------
;; Nikita Makarevich (DDRDmakar) 2021-2024
;; dedrtos@gmail.com
;; Distributed under MIT license
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

(defun create-file-if-not-exists (filePath)
  (unless (file-exists-p filePath)
    (with-temp-buffer (write-file filePath))))

(defun create-dir-if-not-exists (dirPath)
  (unless (file-directory-p dirPath)
    (make-directory dirPath)))

(defun ded/int-to-binary-string (x &optional w print-message)
  "Convert an integer into it's binary representation in string format"
  (interactive "nInteger: \nnWidth: \np")
  ;; 3-rd argument is needed to distinguish when function is called interactively
  (let ((a x) (res ""))
    ;; Make number positive if it is negative
    (when (and (< a 0) (not w)) (error "You need to specify width for negative numbers"))
    (when (< a 0)
      (setq a (if w
        (+ a (expt 2 w))
        (* a -1))))
    (when (< a 0) (error "Number does not fit into this width"))
    ;; Write bits into string
    (setq res
      (concat (mapcar
        (lambda (i) (if (= (logand a (lsh 1 i)) 0) ?0 ?1))
        (number-sequence (- (ceiling (log (+ a 1) 2)) 1) 0 -1))))
    ;; Pad start with zeros if needed
    (when  (and w (< (length res) w))
      (setq res
        (concat
          (make-string (- w (length res)) ?0)
          res)))
    ;; Return string representation
    (when print-message (message res))
    res))

;; Display file name command
(defun ded/show-file-name ()
  "Show the full path file name in the minibuffer."
  (interactive)
  (message (buffer-file-name)))

(defun ded/copy-directory-path ()
  "Copy the current directory into the kill ring."
  (interactive)
  (kill-new default-directory))

(defun ded/copy-file-path ()
  "Copy the current directory into the kill ring."
  (interactive)
  (kill-new buffer-file-name))

;; Display file name command
(defun ded/copy-file-name ()
  "Copy file name into the kill ring."
  (interactive)
  (kill-new (file-name-nondirectory buffer-file-name)))

;;==================================[ Load system-specific config ]====================================
(load-user-file "system-specific.el")

;; Custom set variables
(setq custom-file (expand-file-name "custom.el" user-init-dir))
(create-file-if-not-exists custom-file)

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
(load-user-file "hdl.el")
(load-user-file "visual.el")
(load-user-file "org.el")
(load-user-file "addition.el")

(load-user-file "variables.el") ;; Should be executed after loading all modules

;;==================================[ Load custom variables ]====================================
(load custom-file)

;;=============================================================================
;;==================================[ End ]====================================
;;=============================================================================
