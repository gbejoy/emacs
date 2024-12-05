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
;; Make changes to key parts of emacs itself
(use-package emacs
  :config
  (set-frame-font "Source Code Pro-12" nil t)
  (load-theme 'leuven t)
  :custom
  (backup-directory-alist `(("." . ,(concat user-emacs-directory "backups"))))
  ;; Support opening new minibuffers from inside existing minibuffers.
  (enable-recursive-minibuffers t)
  ;; Hide commands in M-x which do not work in the current mode.  Vertico
  ;; commands are hidden in normal buffers. This setting is useful beyond
  ;; Vertico.
  (read-extended-command-predicate #'command-completion-default-include-p)
  (user-full-name "Gokul Bejoy")
  (user-mail-address "imgokulbejoy@gmail.com")
  :init
  ;; Add prompt indicator to `completing-read-multiple'.
  ;; We display [CRM<separator>], e.g., [CRM,] if the separator is a comma.
  (defun crm-indicator (args)
    (cons (format "[CRM%s] %s"
                  (replace-regexp-in-string
                   "\\`\\[.*?]\\*\\|\\[.*?]\\*\\'" ""
                   crm-separator)
                  (car args))
          (cdr args)))
  (advice-add #'completing-read-multiple :filter-args #'crm-indicator)

  ;; Do not allow the cursor in the minibuffer prompt
  (setq minibuffer-prompt-properties
	'(read-only t cursor-intangible t face minibuffer-prompt))
  (add-hook 'minibuffer-setup-hook #'cursor-intangible-mode))

;;;; cus-edit
;; Change customize properties
(use-package cus-edit
  :custom
  (custom-file "~/.emacs.d/custom.el"))

;;;; magit
;; Git porcelain with good interface
(use-package magit)

;;;; orderless
;; Completion style that matches regex without respect to order
(use-package orderless
  :custom
  ;; Configure a custom style dispatcher (see the Consult wiki)
  ;; (orderless-style-dispatchers '(+orderless-consult-dispatch orderless-affix-dispatch))
  ;; (orderless-component-separator #'orderless-escapable-split-on-space)
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles partial-completion)))))

;;;; org
;; For notetaking, scheduling and many more
(use-package org
  :custom
  (org-directory "~/Documents/org/")
  (org-default-notes-file (concat org-directory "inbox.org")))

;;;;; org-agenda
;; Settings for agenda view
(use-package org-agenda
  :bind ("C-c a" . org-agenda))

;;;;; org-capture
;; Templates for jotting down different types of data
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
;; Write important events that happened in daily
(use-package org-journal
  :bind ("C-c j" . org-journal-new-entry)
  :config
  (setq org-element-use-cache nil)
  :custom
  (org-journal-file-type 'daily)
  (org-journal-dir (concat org-directory "journal/")))

;;;;; org-roam
;; Zettelkaisen based note-taking solution in org-mode
(use-package org-roam
  :bind (("C-c n l" . org-roam-buffer-toggle)
	 ("C-c n f" . org-roam-node-find)
	 ("C-c n i" . org-roam-node-insert))
  :ensure t
  :custom
  (org-roam-directory "~/Documents/vault/"))

;;;;; ox-hugo
;; Export org-files into hugo pages
(use-package ox-hugo
  :ensure t
  :pin melpa
  :after ox)

;;;; pdf-tools
;; Read pdf within emacs using poppler
(use-package pdf-tools
  :magic ("%PDF" . pdf-view-mode)
  :config
  (pdf-tools-install :no-query))

;;;; savehist
;; Persist history over Emacs restarts. Vertico sorts by history position.
(use-package savehist
  :init
  (savehist-mode))

;;;; vertico
;; VERTical COmpletion for better completion-at-point
(use-package vertico
;:custom
;; (vertico-scroll-margin 0) ;; Different scroll margin
;; (vertico-count 20) ;; Show more candidates
;; (vertico-resize t) ;; Grow and shrink the Vertico minibuffer
;; (vertico-cycle t) ;; Enable cycling for `vertico-next/previous'
:init
(vertico-mode))
