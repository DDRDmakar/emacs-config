
;;==================================[ Basic variables and modes for Emacs kernel ]====================================

;; Disable startup message
(setq inhibit-startup-message t inhibit-startup-echo-area-message t)

;;(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
;;(tooltip-mode -1)

;;(set-fringe-mode 10) ; Word wrap marks
(show-paren-mode 1) ; Highlight parentheses
(delete-selection-mode 1) ; Delete selected region by typing or yanking text
;;(setq visible-bell t) ; Flash screen instead of bell sound
(setq visible-bell nil
      ring-bell-function 'ignore)
;;(global-visual-line-mode 1) ; Wrap words by default
;;(global-hl-line-mode 1) ; Highlight current line

;; Locale
(set-language-environment "UTF-8")

;; Titlebar text
(setq-default frame-title-format '("%b [%m]"))

;; Make ESC quit prompts
;;(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(setq mouse-drag-and-drop-region t)
(setq mouse-drag-and-drop-region-cut-when-buffers-differ t)

(setq scroll-conservatively 101) ;; Scroll just enough to keep cursor on screen

;; Remap C-x C-c to something else to stop occasionaly exiting emacs
;; Command to exit emacs: save-buffers-kill-emacs
(global-set-key "\C-x\C-c" 'whitespace-mode)

;;==================================[ TABs ]====================================
;; C-like languages
(setq-default indent-tabs-mode t)
(setq-default tab-width 4) ;; Assuming you want your tabs to be four spaces wide
(setq-default c-basic-offset tab-width)
;;;; Ruby-like languages
;;(setq ruby-indent-tabs-mode t)
;;(defvaralias 'ruby-indent-level 'tab-width)
;;;; Sgml-like languages
;;(defvaralias 'sgml-basic-offset 'tab-width)

(add-hook 'emacs-lisp-mode-hook
  (lambda ()
    (setq indent-tabs-mode nil)
    (setq tab-width 2)))

(add-hook 'python-mode-hook
  (lambda ()
    (setq indent-tabs-mode t)
    (setq tab-width 4)
    (setq python-indent-offset 4)))

;; Disable auto-indent of previous line when pressing Enter
(setq-default electric-indent-inhibit t)

;;==================================[ Line numbers ]====================================
(column-number-mode) ; Display column numbers in mode line
;;(global-linum-mode t)
;; Disable line numbers for some modes
;;(dolist (mode '(org-mode-hook
;;                term-mode-hook
;;                shell-mode-hook
;;                eshell-mode-hook
;;                treemacs-mode-hook
;;                neotree-mode-hook))
;;  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;;==================================[ Recent files ]====================================
(recentf-mode 1)
(setq recentf-max-menu-items 50)
(setq recentf-max-saved-items 50)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

;;==================================[ Duplicate lines ]====================================
;; Duplicate line
(defun duplicate-line (arg)
  "Duplicate current line, leaving point in lower line."
  (interactive "*p")
  ;; save the point for undo
  (setq buffer-undo-list (cons (point) buffer-undo-list))
  ;; local variables for start and end of line
  (let ((bol (save-excursion (beginning-of-line) (point))) eol)
    (save-excursion
      ;; don't use forward-line for this, because you would have
      ;; to check whether you are at the end of the buffer
      (end-of-line)
      (setq eol (point))
      ;; store the line and disable the recording of undo information
      (let ((line (buffer-substring bol eol))
            (buffer-undo-list t)
            (count arg))
        ;; insert the line arg times
        (while (> count 0)
          (newline)         ;; because there is no newline in 'line'
          (insert line)
          (setq count (1- count))))
      ;; create the undo information
      (setq buffer-undo-list (cons (cons eol (point)) buffer-undo-list))))
  ;; put the point in the lowest line and return
  (next-line arg))

;;(global-set-key [(control ?')]
;;  (lambda () (interactive)
;;    (move-beginning-of-line nil)
;;    (set-mark-command nil)
;;    (next-line)
;;  (move-beginning-of-line nil) ; To prevent remembering column
;;    (kill-ring-save (region-beginning) (region-end))
;;    (yank)
;;    (previous-line)
;;    (pop kill-ring)))

(global-set-key [(control ?')] 'duplicate-line)

;;==================================[ Automatic mode detection ]====================================
(setq auto-mode-alist
  (append
    ;; File name (within directory) starts with a dot.
    ;;'(("/\\.[^/]*\\'" . fundamental-mode)
    ;; File name has no dot.
    ;;("/[^\\./]*\\'" . fundamental-mode)
    ;; File name ends in ‘.C’.
    ;;("\\.C\\'" . c++-mode))
    '(
      ("/[Kk]build\\'" . makefile-gmake-mode))
    auto-mode-alist))

;;==================================[ Open files read-only ]====================================
(when ded/open-files-read-only
  (add-hook 'find-file-hook (lambda ()
    (unless (or (= (buffer-size buffer-file-name) 0)
                (string-match-p ".git/COMMIT_EDITMSG\\'" buffer-file-name))
      (setq buffer-read-only t)) )))

;;==================================[ Backups ]====================================
;; Save all backups into separate folder
;;(setq make-backup-files nil) ;; Disable all backups

;;(setq my-backups-dir "~/EmacsBackups")
;;(create-dir-if-not-exists my-backups-dir)
;;(setq backup-directory-alist `(("." . ,my-backups-dir)))

;;(setq backup-by-copying-when-linked t)
;;(setq delete-old-versions t
;;  kept-new-versions 6
;;  kept-old-versions 2
;;  ;;version-control t
;;  )

;;(defun my-make-backup-file-name (FILE)
;;  (let ((dirname (concat my-backups-dir
;;                         (format-time-string "%y/%m/%d/"))))
;;    (create-dir-if-not-exists dirname)
;;    (concat dirname (file-name-nondirectory FILE))))
;;
;;(setq make-backup-file-name-function #'my-make-backup-file-name)

;;(setq auto-save-default nil) ;; Disable auto save
;;(setq auto-save-interval 1000) ;; Auto save every N characters
;;(setq auto-save-visited-interval 600) ;; Auto save every N seconds
;;(setq auto-save-timeout 600) ;; Auto save every N seconds
