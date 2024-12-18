;;-------------------------------------
;; Nikita Makarevich (DDRDmakar) 2021-2024
;; dedrtos@gmail.com
;; Distributed under MIT license
;;-------------------------------------

;; TODO yasnippet

;; TODO
;;(use-package direx)
;;(global-set-key (kbd "C-x C-j") 'direx:jump-to-directory)

;; Treat _ as part of the word for left-word and right-word functions
(modify-syntax-entry ?_ "w")

;; Enable disabled commands
(put 'scroll-left 'disabled nil)
(put 'upcase-region 'disabled nil)

;; TODO: add this into early-init.el
;; Display time in tab bar
;; (add-to-list 'tab-bar-format 'tab-bar-format-align-right 'append)
;; (add-to-list 'tab-bar-format 'tab-bar-format-global 'append)
;; (setq display-time-format "%a %F %T") ;; "%a %e %b %T"
;; (setq display-time-interval 1)
;; (display-time-mode)

;; Hack to display a clock in the tab-bar
(defun posframe-poshandler-real-top-right (info)
  (cons (- (plist-get info :parent-frame-width)
           (+ (plist-get info :posframe-width) (* (plist-get info :font-width) 2)))
        0))

(defun update-posframe-clock ()
  "Update the clock displayed with posframe"
  (let ((the-time (format-time-string "%H:%M")))
    (if (> (length (tab-bar-tabs)) 1)
        (posframe-show "*clock*"
                       :string the-time
                       :width 8
                       :poshandler 'posframe-poshandler-real-top-right
                       :background-color (plist-get (custom-face-attributes-get 'tab-bar nil) :background))
      (posframe-delete "*clock*"))))

(when (display-graphic-p)
  (run-with-timer
   60 60
   #'update-posframe-clock))
