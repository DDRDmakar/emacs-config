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
