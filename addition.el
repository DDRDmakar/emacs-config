
(use-package counsel-tramp
  :config
  (setq tramp-default-method "ssh")
  (define-key global-map (kbd "C-c t") 'counsel-tramp)
  )

(use-package page-break-lines)

(use-package markdown-mode
  :ensure t
  :mode ("README\\.md\\'" . gfm-mode)
  :init (setq markdown-command "multimarkdown"))

;; TODO yasnippet

;;(progn
;;  (add-to-list 'tab-bar-format 'tab-bar-format-align-right 'append)
;;  (add-to-list 'tab-bar-format 'tab-bar-format-global 'append)
;;  (setq display-time-format "%H:%M")
;;  (setq display-time-default-load-average nil)
;;  (setq display-time-interval 60)
;;  (display-time-mode t)
;;  (tab-bar-mode t)
;;  )
;;
;;
;;(progn
;;  (eval-after-load "tab-bar"
;;    (defun tab-bar-format-align-right ()
;;      "Align the rest of tab bar items to the right."
;;      (let* ((rest (cdr (memq 'tab-bar-format-align-right tab-bar-format)))
;;             (rest (tab-bar-format-list rest))
;;             (rest (mapconcat (lambda (item) (nth 2 item)) rest ""))
;;             (hpos (length rest))
;;             (str (propertize " " 'display `(space :align-to (- right ,hpos 3)))))
;;        `((align-right menu-item ,str ignore)))))
;;  )

(use-package dired+
  :load-path "~/.emacs.d/lisp/dired+.el"
  :defer 1
  :init
  (setq diredp-hide-details-initially-flag nil)
  (setq diredp-hide-details-propagate-flag nil)

  :config
  (diredp-toggle-find-file-reuse-dir 1))

;;(use-package vterm
;;    :load-path "~/.emacs.d/lisp/emacs-libvterm-master/vterm.el")

(setq ediff-split-window-function #'split-window-vertically)

(setq history-delete-duplicates t)
(setq comint-input-ignoredups t)

;;(use-package workgroups2
;;  :config
;;  (workgroups-mode 1)
;;  )


(global-set-key (kbd "C-x ы") 'save-some-buffers)
(global-set-key (kbd "C-x л") 'kill-buffer)
(global-set-key (kbd "C-x к е") 'string-rectangle)
(global-set-key (kbd "C-x к в") 'delete-rectangle)
(global-set-key (kbd "M-s р з") 'highlight-phrase)
(global-set-key (kbd "M-s р к") 'highlight-regexp)
(global-set-key (kbd "M-s р г") 'unhighlight-regexp)
