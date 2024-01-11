;;-------------------------------------
;; Nikita Makarevich (DDRDmakar) 2021-2023
;; dedrtos@gmail.com
;; Distributed under MIT license
;;-------------------------------------

;;==================================[ Drag stuff ]====================================
(use-package drag-stuff
  :config
  (drag-stuff-global-mode)
  :bind (("M-<up>"   . #'drag-stuff-up)
		 ("M-<down>" . #'drag-stuff-down)))

;;==================================[ Auto complete text ]====================================
(use-package dabbrev
  :custom
  (dabbrev-case-replace nil))

;;==================================[ Ivy ]====================================
(use-package ivy-rich
  :if ded/advanced-config)
(use-package ivy-hydra
  :if ded/advanced-config)

(use-package ivy
  ;;:if ded/advanced-config
  :ensure t
  :ensure counsel
  :ensure all-the-icons-ivy-rich
  :bind (("C-s" . counsel-grep-or-swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)	
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :init
  (ivy-rich-mode (if ded/advanced-config 1 0))
  (ivy-mode      (if ded/advanced-config 0 1))
  (all-the-icons-ivy-rich-mode (if ded/enable-icons 1 0))
  (setq all-the-icons-ivy-rich-icon ded/enable-icons)
  (setq history-delete-duplicates t)
  (setq comint-input-ignoredups t)
  )

;; Additional sorting and searching algorithms for ivy
;; Should be activated after ivy and counsel
;;(use-package prescient
;;  :if ded/advanced-config)
;;(use-package ivy-prescient
;;  :if ded/advanced-config
;;  :config
;;  (ivy-prescient-mode))
(use-package smex
  :config
  (smex-initialize))

;;==================================[ Counsel ]====================================
(use-package counsel
  :if ded/advanced-config
  :bind (
    ("M-x" . counsel-M-x)
	  ("C-x b" . counsel-ibuffer)
	  ("C-c b" . counsel-projectile-switch-to-buffer)
	  ("C-x C-f" . counsel-find-file)
	  ("C-M-j" . 'counsel-switch-buffer)
    :map minibuffer-local-map
    ("C-r" . 'counsel-minibuffer-history))
  :custom
  (counsel-linux-app-format-function #'counsel-linux-app-format-function-name-only)
  ;;(ivy-initial-inputs-alist nil) ; Don't start searches with ^
  :config
  (counsel-mode 1))

;;==================================[ Which-key ]====================================
(use-package which-key
  :if ded/super-advanced-config
  :init (which-key-mode)
  :diminish which-key-mode
  :custom
  (which-key-idle-delay 2))
;; Scroll with C-h n and C-h p

;;==================================[ General ]====================================
(use-package general
  :config
  (general-define-key "C-M-j" 'counsel-switch-buffer)
  (general-create-definer ded/leader-keys :prefix "C-c")
  (ded/leader-keys
  ;; "t"  '(:ignore t :which-key "toggles")
  ;; "tt" '(counsel-load-theme :which-key "choose theme")
  ;; "fde" '(lambda () (interactive) (find-file (expand-file-name "~/.emacs.d/Emacs.org")))))
    "<up>"    'windmove-up    
    "<down>"  'windmove-down  
    "<left>"  'windmove-left  
    "<right>" 'windmove-right
	))

;;==================================[ Hydra ]====================================
(use-package hydra
  :defer t)

(defhydra hydra-text-scale (:timeout 4)
  "scale text"
  ("j" text-scale-increase "in")
  ("k" text-scale-decrease "out")
  ("f" nil "finished" :exit t))

;;(ded/leader-keys
;;  "ts" '(hydra-text-scale/body :which-key "scale text"))

;;==================================[ Evil ]====================================
(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  ;;(setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  :config
  ;;(evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  ;;(define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)

  ;; Use visual line motions even outside of visual-line-mode buffers
  ;;(evil-global-set-key 'motion "j" 'evil-next-visual-line)
  ;;(evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))

;; This is a collection of Evil bindings for the parts of Emacs that Evil does not cover properly by default, such as help-mode, M-x calendar, Eshell and more.
(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))


;;==================================[ Russian keystrokes ]====================================
;; Support russian keyboard layout for emacs keystrokes
(cl-loop
  for from across "йцукенгшщзхъфывапролджэячсмитьбюЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖ\ЭЯЧСМИТЬБЮ№."
  for to   across "qwertyuiop[]asdfghjkl;'zxcvbnm,.QWERTYUIOP{}ASDFGHJKL:\"ZXCVBNM<>#/"
  do
  (eval `(define-key key-translation-map (kbd ,(concat "C-" (string from))) (kbd ,(concat     "C-" (string to)))))
  (eval `(define-key key-translation-map (kbd ,(concat "M-" (string from))) (kbd ,(concat     "M-" (string to))))))

(global-set-key (kbd "C-x ы") 'save-some-buffers)
(global-set-key (kbd "C-x л") 'kill-buffer)
(global-set-key (kbd "C-x и") 'counsel-ibuffer)
(global-set-key (kbd "C-c и") 'counsel-projectile-switch-to-buffer)
(global-set-key (kbd "C-x к е") 'string-rectangle)
(global-set-key (kbd "C-x к в") 'delete-rectangle)
(global-set-key (kbd "M-s р з") 'highlight-phrase)
(global-set-key (kbd "M-s р к") 'highlight-regexp)
(global-set-key (kbd "M-s р г") 'unhighlight-regexp)
(global-set-key (kbd "M-s р ю") 'highlight-symbol-at-point)

;;==================================[ Backtab ]====================================
(defun indent-region-custom(numSpaces)
  (progn 
    ;; default to start and end of current line
    (setq regionStart (line-beginning-position))
    (setq regionEnd (line-end-position))
    
    ;; if there's a selection, use that instead of the current line
    (when (use-region-p)
      (setq regionStart (region-beginning))
      (setq regionEnd (region-end))
      )
    
    (save-excursion ; restore the position afterwards            
      (goto-char regionStart) ; go to the start of region
      (setq start (line-beginning-position)) ; save the start of the line
      (goto-char regionEnd) ; go to the end of region
      (setq end (line-end-position)) ; save the end of the line
      
      (indent-rigidly start end numSpaces) ; indent between start and end
      (setq deactivate-mark nil) ; restore the selected region
      )
    )
  )

(defun untab-region (N)
  (interactive "p")
  (indent-region-custom (* tab-width -1))
)

;;(defun tab-region (N)
;;  (interactive "p")
;;  (if (active-minibuffer-window)
;;    (minibuffer-complete)    ; tab is pressed in minibuffer window -> do completion
;;  ;; else
;;  (if (string= (buffer-name) "*shell*")
;;    (comint-dynamic-complete) ; in a shell, use tab completion
;;  ;; else
;;  (if (use-region-p)    ; tab is pressed is any other buffer -> execute with space insertion
;;    (indent-region-custom 4) ; region was selected, call indent-region-custom
;;    (insert "    ") ; else insert four spaces as expected
;;  )))
;;)

(global-set-key (kbd "<backtab>") 'untab-region)
;;(global-set-key (kbd "<tab>") 'tab-region)


;;==================================[ Multiple cursors ]====================================
(use-package multiple-cursors
  :if ded/advanced-config)

;;==================================[ Tiny-expand ]====================================
(use-package tiny
  :config
  (tiny-setup-default))
