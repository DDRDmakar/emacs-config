
;;==================================[ Git ]====================================
(when ded/super-advanced-config
  (use-package magit
    :ensure t
    :ensure git-modes
    ;;:ensure evil-magit
    :config
    (load "magit-pretty-graph")
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
    :custom
    (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1)
    :bind
    (:map global-map
          ("C-M-;" . magit-status)))
  
  (use-package forge)) ;; Integration with GitHub

;;==================================[ Hilight indentation ]====================================
(when ded/advanced-config
  (use-package highlight-indent-guides
	:hook (prog-mode . highlight-indent-guides-mode)
	:custom
	(highlight-indent-guides-method 'character)))

;;==================================[ Theme and ligatures ]====================================
(when ded/material-theme
  (use-package material-theme
	:config
	(load-theme 'material t)))

(if ded/fira-code
	(use-package fira-code-mode
	  ;;:custom (fira-code-mode-disabled-ligatures '(
	  ;;	"www" "**" "***" "**/" "*>" "*/" "\\\\" "\\\\\\"
	  ;;  "{-" "[]" "::" ":::" ":=" "!!" "!=" "!==" "-}"
	  ;;  "--" "---" "-->" "->" "->>" "-<" "-<<" "-~"
	  ;;  "#{" "#[" "##" "###" "####" "#(" "#?" "#_" "#_("
	  ;;  ".-" ".=" ".." "..<" "..." "?=" "??" ";;" "/*"
	  ;;  "/**" "/=" "/==" "/>" "//" "///" "&&" "||" "||="
	  ;;  "|=" "|>" "^=" "$>" "++" "+++" "+>" "=:=" "=="
	  ;;  "===" "==>" "=>" "=>>" "<=" "=<<" "=/=" ">-" ">="
	  ;;  ">=>" ">>" ">>-" ">>=" ">>>" "<*" "<*>" "<|" "<|>"
	  ;;  "<$" "<$>" "<!--" "<-" "<--" "<->" "<+" "<+>" "<="
	  ;;  "<==" "<=>" "<=<" "<>" "<<" "<<-" "<<=" "<<<" "<~"
	  ;;  "<~~" "</" "</>" "~@" "~-" "~=" "~>" "~~" "~~>" "%%"
	  ;;  "x" ":" "+" "+" "*"))
	  :custom
	  (fira-code-mode-disabled-ligatures '("x"))
	  :config
	  (set-frame-font (font-spec :family "Fira Code" :size ded/font-size) nil t)
	  ;; Enable the www ligature in every possible major mode
	  ;;(ligature-set-ligatures 't '("www"))
	  :hook prog-mode)
  
	(set-frame-font (font-spec :family ded/mono-font :size ded/font-size) nil t))

(when ded/doom-theme
  ;; LOOK THEME LIST IN SEPARATE FILE
  (use-package doom-themes
	:ensure t
	:config
	;; Global settings (defaults)
	(setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
          doom-themes-enable-italic t) ; if nil, italics is universally disabled
	(load-theme ded/doom-theme t)
	
	;; Enable flashing mode-line on errors
	(doom-themes-visual-bell-config)
	;; Enable custom neotree theme (all-the-icons must be installed!)
	;;(doom-themes-neotree-config)
	;; or for treemacs users
	;;(setq doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
	;;(doom-themes-treemacs-config)
	;; Corrects (and improves) org-mode's native fontification.
	(doom-themes-org-config)
	))

(when ded/advanced-config
  ;; Icons for tree view
  (use-package all-the-icons
	:if (display-graphic-p)
  ))

;;==================================[ Very Large Files ]====================================
(use-package vlf)
(require 'vlf-setup)

;;==================================[ Projectile ]====================================
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
	:config (counsel-projectile-mode)))

;;==================================[ Tree view ]====================================
(use-package neotree
  :bind
  ([f8] . 'neotree-toggle)
  :custom
  (neo-window-fixed-size nil))

(when ded/advanced-config
  (use-package treemacs
    :bind
    (:map global-map
          ("M-0"       . treemacs-select-window)
          ("C-x t 1"   . treemacs-delete-other-windows)
          ("C-x t t"   . treemacs)
          ("C-x t B"   . treemacs-bookmark)
          ("C-x t C-t" . treemacs-find-file)
          ("C-x t M-t" . treemacs-find-tag)))
  
  (use-package treemacs-icons-dired
    :hook (dired-mode . treemacs-icons-dired-enable-once))
  (use-package treemacs-evil
    :after (treemacs evil))
  (use-package treemacs-projectile
    :after (treemacs projectile))
  (use-package treemacs-magit
    :after (treemacs magit))
  )

;;==================================[ Tab bar ]====================================
;;(tab-bar-mode t)
(global-tab-line-mode t)
(setq tab-line-new-button-show nil) ;; do not show add-new button
(setq tab-line-close-button-show nil) ;; do not show close button
;;(setq tab-line-separator "")  ;; set it to empty

(setq tab-line-tabs-function 'tab-line-tabs-mode-buffers) ;; Group tabs by major mode

(set-face-attribute 'tab-line nil ;; background behind tabs
  :background "gray30"
  :foreground "gray30"
  :distant-foreground "gray50"
  :height 1.0
  :box nil)
(set-face-attribute 'tab-line-tab nil ;; active tab in another window
  :inherit 'tab-line
  :foreground "gray70"
  :background "gray90"
  :box nil)
(set-face-attribute 'tab-line-tab-current nil ;; active tab in current window
  :background "#8c299c"
  :foreground "white"
  :box nil)
(set-face-attribute 'tab-line-tab-inactive nil ;; inactive tab
  :background "gray60"
  :foreground "black"
  :box nil)
(set-face-attribute 'tab-line-highlight nil ;; mouseover
  :background "white"
  :foreground 'unspecified)

;;==================================[ Languages ]====================================
(when ded/super-advanced-config
  (use-package rust-mode)
  (use-package kotlin-mode)
  (use-package lsp-mode)
  )

;;==================================[ Text highlighting ]====================================
(use-package hi-lock
  :config
  (setq hi-ded/face-names '(
    "red" "orange" "yellow" "green" "sky" "blue" "violet"
    "black" "gray" "white"
    "cyan" "magenta" "blood" "brown" "olive" "pink"))
  (setq hi-ded/color-names '(
    "red" "orange" "yellow" "green" "deep sky blue" "blue" "dark violet"
    "black" "gray" "white"
    "cyan" "magenta" "dark red" "saddle brown" "olive drab" "hot pink"))
  (setq hi-ded/color-is-dark '(
    nil nil nil nil nil t t
    t nil nil
    nil nil t t t nil))
  
  (dotimes (i 16)
    (let* ((face-symbol-name (concat "ded/" "bg-" (nth i hi-ded/face-names))))
      (eval
        `(defface ,(intern face-symbol-name)
          '((t ( :foreground ,(if (nth i hi-ded/color-is-dark) "white" "black")
                 :background ,(nth i hi-ded/color-names)
                 )))
          "Face for hi-lock mode."))
      (add-to-list 'hi-lock-face-defaults face-symbol-name)))

  (dotimes (i 16)
    (let* ((face-symbol-name (concat "ded/" "bgul-" (nth i hi-ded/face-names))))
      (eval
        `(defface ,(intern face-symbol-name)
          '((t ( :foreground ,(if (nth i hi-ded/color-is-dark) "white" "black")
                 :background ,(nth i hi-ded/color-names)
                 :underline "red"
                 )))
          "Face for hi-lock mode."))
      (add-to-list 'hi-lock-face-defaults face-symbol-name)))

  (dotimes (i 16)
    (let* ((face-symbol-name (concat "ded/" "text-" (nth i hi-ded/face-names))))
      (eval
        `(defface ,(intern face-symbol-name)
          '((t ( :foreground ,(nth i hi-ded/color-names)
                 )))
          "Face for hi-lock mode."))
      (add-to-list 'hi-lock-face-defaults face-symbol-name)))

  (dotimes (i 16)
    (let* ((face-symbol-name (concat "ded/" "textul-" (nth i hi-ded/face-names))))
      (eval
        `(defface ,(intern face-symbol-name)
          '((t ( :foreground ,(nth i hi-ded/color-names)
                 :underline ,(nth i hi-ded/color-names)
                 )))
          "Face for hi-lock mode."))
      (add-to-list 'hi-lock-face-defaults face-symbol-name)))

  (dotimes (i 16)
    (let* ((face-symbol-name (concat "ded/" "textb-" (nth i hi-ded/face-names))))
      (eval
        `(defface ,(intern face-symbol-name)
          '((t ( :foreground ,(nth i hi-ded/color-names)
                 :bold t
                 )))
          "Face for hi-lock mode."))
      (add-to-list 'hi-lock-face-defaults face-symbol-name)))
  
  (setq hi-lock-face-defaults (sort hi-lock-face-defaults #'string-lessp))
  ) ;; end use-package
