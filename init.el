;;; Startup

;;;; MELPA

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;;; Packages

;;;; emacs
;; Make changes to key parts of emacs itself
(use-package emacs
  :config
  (set-frame-font "Source Code Pro-12" nil t)
  (load-theme 'tsdh-light t)
  :custom
  ;; Set directory for backup files
  (backup-directory-alist `(("." . ,(concat user-emacs-directory "backups"))))
  ;; Always download from GNU and NonGNU if possible
  ;;  (use-package-always-pin "nongnu")
  ;; Use y-or-n everywhere
  (use-short-answers t)
  (user-full-name "Gokul Bejoy")
  (user-mail-address "imgokulbejoy@gmail.com"))

;;;; cus-edit
;; Change customize properties
(use-package cus-edit
  :custom
  (custom-file "~/.emacs.d/custom.el"))

;;;; magit
;; Git porcelain with good interface
(use-package magit
  :ensure t)

;;;; org
;; For notetaking, scheduling and many more
(use-package org
  :custom
  (org-directory "~/Documents/org/")
  (org-default-notes-file (concat org-directory "inbox.org"))
  (org-agenda-files '("~/Documents/org/todo.org"
		      "~/Documents/org/inbox.org")))

;;;;; org-agenda
;; Settings for agenda view
(use-package org-agenda
  :bind ("C-c o a" . org-agenda))

;;;;; org-capture
;; Immediately jot down information as soon as possible
(use-package org-capture
  :bind ("C-c o c" . org-capture)
  :config
  (setq org-capture-templates
	'(("t" "Todo" entry (file "~/Documents/org/todo.org")
	   "* TODO %?\n %i\n")
	  ("i" "Inbox" entry (file "~/Documents/org/inbox.org")
	   "* %?\n %i\n"))))

;;;; pdf-tools
;; Read pdf within emacs using poppler
(use-package pdf-tools
  :ensure t
  :magic ("%PDF" . pdf-view-mode)
  :config
  (pdf-tools-install :no-query))

;;;; which-key
;; Shows available keybinds after pressing one character
(use-package which-key
  :ensure t
  :init
  (which-key-mode))
