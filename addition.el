
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
  :init (doom-modeline-mode 1))
