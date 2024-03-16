;;-------------------------------------
;; Nikita Makarevich (DDRDmakar) 2021-2023
;; dedrtos@gmail.com
;; Distributed under MIT license
;;-------------------------------------

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

(setq backward-delete-char-untabify-method 'hungry)

;; TODO
;; (all-the-icons-ivy-rich-mode (if ded/enable-icons 1 0))
;;    (setq all-the-icons-ivy-rich-icon ded/enable-icons)

;; TODO set up fixed-pitch face for Windows
(progn
  ;; Ensure that anything that should be fixed-pitch in Org files appears that way
  (set-face-attribute 'fixed-pitch nil :font ded/mono-font)
  (set-face-attribute 'org-block nil    :foreground nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-table nil    :inherit 'fixed-pitch)
  (set-face-attribute 'org-formula nil  :inherit 'fixed-pitch)
  (set-face-attribute 'org-code nil     :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-table nil    :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-checkbox nil  :inherit 'fixed-pitch)
  (set-face-attribute 'line-number nil :inherit 'fixed-pitch)
  (set-face-attribute 'line-number-current-line nil :inherit 'fixed-pitch)
  )

;; A modern list API for Emacs
(use-package dash)

(use-package fpga)

;;(use-package direx)
;;(global-set-key (kbd "C-x C-j") 'direx:jump-to-directory)
