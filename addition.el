
(use-package counsel-tramp
  :config
  (setq tramp-default-method "ssh")
  (define-key global-map (kbd "C-c t") 'counsel-tramp)
  )



(use-package visual-regexp-steroids
  :config
  (define-key global-map (kbd "C-c r") 'vr/replace)
  (define-key global-map (kbd "C-c q") 'vr/query-replace)
  ;; if you use multiple-cursors, this is for you:
  (define-key global-map (kbd "C-c m") 'vr/mc-mark)
  ;; to use visual-regexp-steroids's isearch instead of the built-in regexp isearch, also include the following lines:
  (define-key esc-map (kbd "C-r") 'vr/isearch-backward) ;; C-M-r
  (define-key esc-map (kbd "C-s") 'vr/isearch-forward) ;; C-M-s
  )

;; Есть несколько способов прикрутить проекты к емаксу
;; 1 - projectile и то, что с ним интегрируется
;;     надо подружить его с ivy(counsel) и с tab-line
;; 2 - emacs project
;;     надо подружить его с ivy(counsel) и с tab-line
;;     

(use-package ibuffer-projectile)

(use-package bufler)

(use-package doom-modeline
  :ensure t
  :init
  (doom-modeline-mode 1)
  :custom (
  (doom-modeline-icon nil)
  (doom-modeline-workspace-name nil))
  )

;; Windows kostyl
(when ded/windows-env
  (setq treemacs-python-executable "C:\\Users\\PSPOD\\AppData\\Local\\Programs\\Python\\Python310\\python.exe")
)


(require 'whitespace)


(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-center-content t))


;; ///////////////////////////// Backtab

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
