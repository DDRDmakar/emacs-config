;;-------------------------------------
;; Nikita Makarevich (DDRDmakar) 2021-2023
;; dedrtos@gmail.com
;; Distributed under MIT license
;;-------------------------------------

(defun ded/org-font-setup ()
  ;; Replace list hyphen with triangle
  (font-lock-add-keywords 'org-mode
                          '(("^ *\\([-]\\) "
                             (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "►"))))))

  ;; Set faces for heading levels
  (dolist (face '((org-level-1 . 1.2)
                  (org-level-2 . 1.1)
                  (org-level-3 . 1.05)
                  (org-level-4 . 1.0)
                  (org-level-5 . 1.0)
                  (org-level-6 . 1.0)
                  (org-level-7 . 1.0)
                  (org-level-8 . 1.0)))
    (set-face-attribute (car face) nil :font ded/sans-font :weight 'regular :height (cdr face)))

  ;; Ensure that anything that should be fixed-pitch in Org files appears that way
  (set-face-attribute 'fixed-pitch nil  :font ded/mono-font)
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
  (set-face-attribute 'line-number-current-line nil :inherit 'fixed-pitch))

(defun ded/org-mode-setup ()
  (org-indent-mode)
  (variable-pitch-mode 1)
  (visual-line-mode 1)
  (auto-fill-mode 0)
  (setq truncate-lines nil))

(use-package org
  :if ded/advanced-config
	:pin org
	:commands (org-capture org-agenda)
	:hook (org-mode . ded/org-mode-setup)
	:config
	(setq org-ellipsis " ▾")
	
	(setq org-agenda-start-with-log-mode t)
	(setq org-log-done 'time)
	(setq org-log-into-drawer t)
	(setq org-hide-emphasis-markers t)
	(ded/org-font-setup))


  ;;(setq org-agenda-files
  ;;      '("~/Projects/Code/emacs-from-scratch/OrgFiles/Tasks.org"
  ;;        "~/Projects/Code/emacs-from-scratch/OrgFiles/Habits.org"
  ;;        "~/Projects/Code/emacs-from-scratch/OrgFiles/Birthdays.org"))

  ;;(require 'org-habit)
  ;;(add-to-list 'org-modules 'org-habit)
  ;;(setq org-habit-graph-column 60)
  ;;
  ;;(setq org-todo-keywords
  ;;  '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d!)")
  ;;    (sequence "BACKLOG(b)" "PLAN(p)" "READY(r)" "ACTIVE(a)" "REVIEW(v)" "WAIT(w@/!)" "HOLD(h)" "|" "COMPLETED(c)" "CANC(k@)")))

  ;;(setq org-refile-targets
  ;;  '(("Archive.org" :maxlevel . 1)
  ;;    ("Tasks.org" :maxlevel . 1)))

  ;;;; Save Org buffers after refiling!
  ;;(advice-add 'org-refile :after 'org-save-all-org-buffers)

  ;;(setq org-tag-alist
  ;;  '((:startgroup)
  ;;     ; Put mutually exclusive tags here
  ;;     (:endgroup)
  ;;     ("@errand" . ?E)
  ;;     ("@home" . ?H)
  ;;     ("@work" . ?W)
  ;;     ("agenda" . ?a)
  ;;     ("planning" . ?p)
  ;;     ("publish" . ?P)
  ;;     ("batch" . ?b)
  ;;     ("note" . ?n)
  ;;     ("idea" . ?i)))

  ;;;; Configure custom agenda views
  ;;(setq org-agenda-custom-commands
  ;; '(("d" "Dashboard"
  ;;   ((agenda "" ((org-deadline-warning-days 7)))
  ;;    (todo "NEXT"
  ;;      ((org-agenda-overriding-header "Next Tasks")))
  ;;    (tags-todo "agenda/ACTIVE" ((org-agenda-overriding-header "Active Projects")))))
  ;;
  ;;  ("n" "Next Tasks"
  ;;   ((todo "NEXT"
  ;;      ((org-agenda-overriding-header "Next Tasks")))))
  ;;
  ;;  ("W" "Work Tasks" tags-todo "+work-email")
  ;;
  ;;  ;; Low-effort next actions
  ;;  ("e" tags-todo "+TODO=\"NEXT\"+Effort<15&+Effort>0"
  ;;   ((org-agenda-overriding-header "Low Effort Tasks")
  ;;    (org-agenda-max-todos 20)
  ;;    (org-agenda-files org-agenda-files)))
  ;;
  ;;  ("w" "Workflow Status"
  ;;   ((todo "WAIT"
  ;;          ((org-agenda-overriding-header "Waiting on External")
  ;;           (org-agenda-files org-agenda-files)))
  ;;    (todo "REVIEW"
  ;;          ((org-agenda-overriding-header "In Review")
  ;;           (org-agenda-files org-agenda-files)))
  ;;    (todo "PLAN"
  ;;          ((org-agenda-overriding-header "In Planning")
  ;;           (org-agenda-todo-list-sublevels nil)
  ;;           (org-agenda-files org-agenda-files)))
  ;;    (todo "BACKLOG"
  ;;          ((org-agenda-overriding-header "Project Backlog")
  ;;           (org-agenda-todo-list-sublevels nil)
  ;;           (org-agenda-files org-agenda-files)))
  ;;    (todo "READY"
  ;;          ((org-agenda-overriding-header "Ready for Work")
  ;;           (org-agenda-files org-agenda-files)))
  ;;    (todo "ACTIVE"
  ;;          ((org-agenda-overriding-header "Active Projects")
  ;;           (org-agenda-files org-agenda-files)))
  ;;    (todo "COMPLETED"
  ;;          ((org-agenda-overriding-header "Completed Projects")
  ;;           (org-agenda-files org-agenda-files)))
  ;;    (todo "CANC"
  ;;          ((org-agenda-overriding-header "Cancelled Projects")
  ;;           (org-agenda-files org-agenda-files)))))))

  ;;(setq org-capture-templates
  ;;  `(("t" "Tasks / Projects")
  ;;    ("tt" "Task" entry (file+olp "~/Projects/Code/emacs-from-scratch/OrgFiles/Tasks.org" "Inbox")
  ;;         "* TODO %?\n  %U\n  %a\n  %i" :empty-lines 1)
  ;;
  ;;    ("j" "Journal Entries")
  ;;    ("jj" "Journal" entry
  ;;         (file+olp+datetree "~/Projects/Code/emacs-from-scratch/OrgFiles/Journal.org")
  ;;         "\n* %<%I:%M %p> - Journal :journal:\n\n%?\n\n"
  ;;         ;; ,(dw/read-file-as-string "~/Notes/Templates/Daily.org")
  ;;         :clock-in :clock-resume
  ;;         :empty-lines 1)
  ;;    ("jm" "Meeting" entry
  ;;         (file+olp+datetree "~/Projects/Code/emacs-from-scratch/OrgFiles/Journal.org")
  ;;         "* %<%I:%M %p> - %a :meetings:\n\n%?\n\n"
  ;;         :clock-in :clock-resume
  ;;         :empty-lines 1)
  ;;
  ;;    ("w" "Workflows")
  ;;    ("we" "Checking Email" entry (file+olp+datetree "~/Projects/Code/emacs-from-scratch/OrgFiles/Journal.org")
  ;;         "* Checking Email :email:\n\n%?" :clock-in :clock-resume :empty-lines 1)
  ;;
  ;;    ("m" "Metrics Capture")
  ;;    ("mw" "Weight" table-line (file+headline "~/Projects/Code/emacs-from-scratch/OrgFiles/Metrics.org" "Weight")
  ;;     "| %U | %^{Weight} | %^{Notes} |" :kill-buffer t)))

  ;;(define-key global-map (kbd "C-c j")
  ;;  (lambda () (interactive) (org-capture nil "jj")))

(use-package org-bullets
  :if ded/advanced-config
	:hook (org-mode . org-bullets-mode)
	:custom
	(org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

;;(defun ded/org-mode-visual-fill ()
;;  (setq visual-fill-column-width 100
;;        visual-fill-column-center-text t)
;;  (visual-fill-column-mode 1))

;;(use-package visual-fill-column
;;  :hook (org-mode . ded/org-mode-visual-fill))

(when ded/advanced-config
  (with-eval-after-load 'org
	(org-babel-do-load-languages
     'org-babel-load-languages
     '((emacs-lisp . t)
       (python . t)))
	
	(push '("conf-unix" . conf-unix) org-src-lang-modes)))

;;(with-eval-after-load 'org
;;  ;; This is needed as of Org 9.2
;;  (require 'org-tempo)
;;
;;  (add-to-list 'org-structure-template-alist '("sh" . "src shell"))
;;  (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
;;  (add-to-list 'org-structure-template-alist '("py" . "src python")))

;;;; Automatically tangle our Emacs.org config file when we save it
;;(defun ded/org-babel-tangle-config ()
;;  (when (string-equal (file-name-directory (buffer-file-name))
;;                      (expand-file-name user-emacs-directory))
;;    ;; Dynamic scoping to the rescue
;;    (let ((org-confirm-babel-evaluate nil))
;;      (org-babel-tangle))))
;;
;;(add-hook 'org-mode-hook (lambda () (add-hook 'after-save-hook #'ded/org-babel-tangle-config)))
