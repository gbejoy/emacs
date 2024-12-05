;;; Startup

;;;; MELPA

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;;; Packages
;;;; corfu
;; In buffer autocomplete
(use-package corfu
  :ensure t
  :init
  (global-corfu-mode))

;;;; emacs

(use-package emacs
  :config
  (set-frame-font "Source Code Pro-12" nil t)
  (load-theme 'leuven t)
  :custom
  (backup-directory-alist `(("." . ,(concat user-emacs-directory "backups"))))
  (user-full-name "Gokul Bejoy")
  (user-mail-address "imgokulbejoy@gmail.com"))

;;;; cus-edit

(use-package cus-edit
  :custom
  (custom-file "~/.emacs.d/custom.el"))

;;;; magit
(use-package magit)

;;;; org

(use-package org
  :custom
  (org-directory "~/Documents/org/")
  (org-default-notes-file (concat org-directory "inbox.org")))

;;;;; org-agenda
(use-package org-agenda
  :bind ("C-c a" . org-agenda))

;;;;; org-capture
(use-package org-capture
  :after org
  :bind ("C-c c" . org-capture)
  :custom
  (org-capture-templates
   '(
     ;; Inbox
     ("i" "Inbox" entry (file "inbox.org"))
     ;; Todo
     ("t" "Todo")
     ("td" "Todo" entry (file "todo.org") "* TODO %?\n %i\n")
     ("tt" "Todo Today" entry (file+headline "todo.org" "Misc") "* TODO %t\n %?\n %i\n"))))

;;;;; org-journal
(use-package org-journal
  :bind ("C-c j" . org-journal-new-entry)
  :config
  (setq org-element-use-cache nil)
  :custom
  (org-journal-file-type 'daily)
  (org-journal-dir (concat org-directory "journal/")))

;;;;; org-roam
(use-package org-roam
  :ensure t
  :custom
  (org-roam-directory "~/Documents/vault/"))

;;;;; ox-hugo
(use-package ox-hugo
  :pin melpa
  :after ox)

;;;; pdf-tools
(use-package pdf-tools
  :magic ("%PDF" . pdf-view-mode)
  :config
  (pdf-tools-install :no-query))
