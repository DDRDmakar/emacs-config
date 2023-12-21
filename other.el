;;-------------------------------------
;; Nikita Makarevich (DDRDmakar) 2021-2023
;; dedrtos@gmail.com
;; Distributed under MIT license
;;-------------------------------------

;;==================================[ Very Large Files ]====================================
(use-package vlf)
(require 'vlf-setup)

;;==================================[ Git ]====================================
(use-package magit
  :if ded/super-advanced-config
  :ensure t
  :ensure git-modes
  ;;:ensure evil-magit
  :init
  (general-create-definer ded/magit-keys :prefix "C-c")
  (ded/magit-keys
	"g" '(:ignore t :which-key "git")
	"gi" 'magit-init
	"gs" 'magit-status
	"gd" 'magit-diff-unstaged
	"gc" 'magit-branch-or-checkout
	"gl" '(:ignore t :which-key "log")
	"glc" 'magit-log-current
	"glf" 'magit-log-buffer-file
	"gb" 'magit-branch
	"gP" 'magit-push-current
	"gp" 'magit-pull-branch
	"gf" 'magit-fetch
	"gF" 'magit-fetch-all
	"gr" 'magit-rebase)
  :config
  (load "magit-pretty-graph") ;; local
  (define-key magit-mode-map 
    (kbd "q") 
    (lambda() (interactive) (magit-mode-bury-buffer t)))
  (global-set-key (kbd "C-x g") 'magit-status)
  (add-hook 'magit-status-mode-hook
    (lambda () (tab-line-mode t)))
  (add-hook 'magit-log-mode-hook
    (lambda () (tab-line-mode t)))
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1)
  (ediff-split-window-function #'split-window-vertically)
  :bind
  (:map global-map
        ("C-M-;" . magit-status)))

(use-package forge ;; Integration with GitHub
  :if ded/super-advanced-config)

;;==================================[ Projects ]====================================
(when ded/super-advanced-config
  (use-package projectile
	:diminish projectile-mode
	:config (projectile-mode)
	:custom ((projectile-completion-system 'ivy))
	:bind-keymap
	("C-c p" . projectile-command-map)
	:init
    ;;;; NOTE: Set this to the folder where you keep your Git repos!
	;;(when (file-directory-p "~/Projects/Code")
	;;  (setq projectile-project-search-path '("~/Projects/Code")))
	(setq projectile-switch-project-action #'projectile-dired))

  (use-package counsel-projectile
	:after projectile
	:config (counsel-projectile-mode))

  (use-package ibuffer-projectile)

  (use-package bufler)
  )

;;==================================[ Languages ]====================================
(when ded/advanced-config
  (use-package rust-mode)
  (use-package kotlin-mode)
  )
(when ded/super-advanced-config
  (use-package lsp-mode)
  )

;;==================================[ Tramp ]====================================
(use-package counsel-tramp
  :config
  (setq tramp-default-method "ssh")
  (define-key global-map (kbd "C-c t") 'counsel-tramp)
  )

;;==================================[ Markdown ]====================================
(use-package markdown-mode
  :if ded/advanced-config
  :ensure t
  :mode ("README\\.md\\'" . gfm-mode)
  :init (setq markdown-command "multimarkdown"))

;;==================================[ Dired+ ]====================================
(use-package dired+ ;; local
  :if ded/advanced-config
  :load-path "~/.emacs.d/lisp/dired+.el"
  :defer 1
  :init
  (setq diredp-hide-details-initially-flag nil)
  (setq diredp-hide-details-propagate-flag nil)

  :config
  (diredp-toggle-find-file-reuse-dir 1))
