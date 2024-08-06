;;-------------------------------------
;; Nikita Makarevich (DDRDmakar) 2021-2024
;; dedrtos@gmail.com
;; Distributed under MIT license
;;-------------------------------------

;;==================================[ Tab bar ]====================================
(when ded/advanced-config
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
)

;;==================================[ Theme and ligatures ]====================================
(use-package material-theme
  :if ded/material-theme
	:config
	(load-theme 'material t))

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
    (add-hook 'prog-mode-hook
      (lambda ()
        (prettify-symbols-mode (if (display-graphic-p) t -1))))
    ;;:hook prog-mode
    )
  
  ;; else
  (set-frame-font (font-spec :family ded/mono-font :size ded/font-size) nil t)
  )

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
	(when ded/super-advanced-config (doom-themes-org-config))
	))

(use-package doom-modeline
  :if ded/super-advanced-config
  :ensure t
  :init
  (doom-modeline-mode 1)
  :custom (
    ;;(doom-modeline-icon ded/enable-icons)
    (doom-modeline-icon nil)
    (doom-modeline-workspace-name nil))
  )

(use-package minions
  :if (not ded/super-advanced-config)
  :config
  (minions-mode (if ded/super-advanced-config 0 1))
  )

;;==================================[ Icons ]====================================
;; Icons for tree view
(use-package all-the-icons
  :if (and ded/super-advanced-config ded/enable-icons))

;;==================================[ Hilight indentation ]====================================
(use-package highlight-indent-guides
  :if ded/advanced-config
	:hook (prog-mode . highlight-indent-guides-mode)
	:custom
	(highlight-indent-guides-method 'character))

;;==================================[ Tree view ]====================================
(use-package neotree
  :bind
  ([f8] . 'neotree-toggle)
  :custom
  (neo-window-fixed-size nil))

(when ded/super-advanced-config
  (use-package treemacs
    :bind
    (:map global-map
          ("M-0"       . treemacs-select-window)
          ("C-x t 1"   . treemacs-delete-other-windows)
          ("C-x t t"   . treemacs)
          ("C-x t B"   . treemacs-bookmark)
          ("C-x t C-t" . treemacs-find-file)
          ("C-x t M-t" . treemacs-find-tag)))

  (when ded/super-advanced-config
    (when ded/enable-icons
      (use-package treemacs-icons-dired
        :hook (dired-mode . treemacs-icons-dired-enable-once)))
    (use-package treemacs-projectile
      :after (treemacs projectile)))
  (use-package treemacs-evil
    :after (treemacs evil))
  (use-package treemacs-magit
    :after (treemacs magit))
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

;;==================================[ Visual regexp steroids ]====================================
(use-package visual-regexp-steroids
  :if ded/super-advanced-config
  :config
  (define-key global-map (kbd "C-c r") 'vr/replace)
  (define-key global-map (kbd "C-c q") 'vr/query-replace)
  ;; if you use multiple-cursors, this is for you:
  (define-key global-map (kbd "C-c m") 'vr/mc-mark)
  ;; to use visual-regexp-steroids's isearch instead of the built-in regexp isearch, also include the following lines:
  (define-key esc-map (kbd "C-r") 'vr/isearch-backward) ;; C-M-r
  (define-key esc-map (kbd "C-s") 'vr/isearch-forward) ;; C-M-s
  )

;;==================================[ Whitespace mode ]====================================
(use-package whitespace
  :if ded/advanced-config
  :custom
  (whitespace-line-column 250)

  :config
  (add-hook 'whitespace-mode-hook
    (lambda () (highlight-indent-guides-mode 0)))
  (setq dashboard-items '((recents  . 10)
                        (bookmarks . 5)
                        (projects . 5)
                        (agenda . 5)
                        (registers . 5)))
  )

;;==================================[ Startup dashboard ]====================================
(use-package dashboard
  :if ded/super-advanced-config
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-center-content t)
  (setq dashboard-set-heading-icons ded/enable-icons)
  (setq dashboard-set-file-icons ded/enable-icons)
  (unless ded/enable-icons
    (setq dashboard-footer-icon ?\s))
  )

;; Display ^L page breaks as tidy horizontal lines
(use-package page-break-lines)

;;==================================[ Distraction-free mode ]====================================
(use-package writeroom-mode
  :if ded/super-advanced-config)

;;==================================[ Git diff highlight in left column ]====================================
(use-package diff-hl
  :if ded/super-advanced-config
  :config
  (global-diff-hl-mode)
  (add-hook 'magit-pre-refresh-hook 'diff-hl-magit-pre-refresh)
  (add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh)
  (setq diff-hl-disable-on-remote t))

;;==================================[ Swap two windows ]====================================
(global-set-key (kbd "C-c s w") 'window-swap-states)
