
(use-package drag-stuff
  :config
  (drag-stuff-global-mode)
  :bind (("M-<up>"   . #'drag-stuff-up)
		 ("M-<down>" . #'drag-stuff-down)))

(use-package dabbrev
  :custom
  (dabbrev-case-replace nil))

(use-package ivy
  :ensure t
  :ensure counsel
  :ensure ivy-rich
  :ensure ivy-hydra
  ;;:ensure all-the-icons-ivy-rich
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
  (ivy-rich-mode 1)
  ;;(all-the-icons-ivy-rich-mode 1)
  (ivy-mode 0))

(use-package counsel
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

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :custom
  (which-key-idle-delay 2))
;; Scroll with C-h n and C-h p

;;(global-set-key (kbd "C-M-j") 'counsel-switch-buffer)
;; (define-key ...) for specific mode keymap

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
	)
  )

(use-package hydra
  :defer t)

(defhydra hydra-text-scale (:timeout 4)
  "scale text"
  ("j" text-scale-increase "in")
  ("k" text-scale-decrease "out")
  ("f" nil "finished" :exit t))

;;(ded/leader-keys
;;  "ts" '(hydra-text-scale/body :which-key "scale text"))

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

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(cl-loop
 for from across "йцукенгшщзхъфывапролджэячсмитьбюЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖ\ЭЯЧСМИТЬБЮ№"
 for to   across "qwertyuiop[]asdfghjkl;'zxcvbnm,.QWERTYUIOP{}ASDFGHJKL:\"ZXCVBNM<>#"
 do
 (eval `(define-key key-translation-map (kbd ,(concat "C-" (string from))) (kbd ,(concat     "C-" (string to)))))
 (eval `(define-key key-translation-map (kbd ,(concat "M-" (string from))) (kbd ,(concat     "M-" (string to))))))


