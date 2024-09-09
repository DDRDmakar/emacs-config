;;-------------------------------------
;; Nikita Makarevich (DDRDmakar) 2021-2024
;; dedrtos@gmail.com
;; Distributed under MIT license
;;-------------------------------------

;;==================================[ Variables tweaking config ]====================================

(setq ded/advanced-config t) ;; Enable advanced functions
(setq ded/super-advanced-config t) ;; Enable super-advanced functions

(setq ded/mono-font "Hack")
(setq ded/sans-font "Liberation Sans")
(setq ded/fira-code t)
(setq ded/font-size 24)
(setq ded/material-theme nil) ;; Enable simple material theme
;; Enable theme from Doom Emacs. Themes list in info.org
(setq ded/doom-theme 'doom-one)
(setq ded/enable-icons t) ;; Warning!!! Do not forget to run all-the-icons-install-fonts after applying config
(setq ded/auto-package-update t)
(setq ded/open-files-read-only nil) ;; May cause problems!
(setq ded/windows-env nil)
(setq ded/org-roam-main-path "~/org")

;;==================================[ Non-customizable stuff ]====================================
;; Windows kostyl
;; (when (eq window-system 'w32) ...)
(when ded/windows-env
  (setq treemacs-python-executable "C:\\Users\\PSPOD\\AppData\\Local\\Programs\\Python\\Python310\\python.exe")
)
