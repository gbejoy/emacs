;; MELPA
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(setq use-package-always-ensure t)	; always ensure all packages

;; Backup File
(setq backup-directory-alist '(("." . "~/.backups"))
      backup-by-copying t
      delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)

;; Custom File
(setq custom-file (locate-user-emacs-file "custom.el"))
(load custom-file :no-error-if-file-is-missing)

(setopt use-short-answers t) 		; always prompt y-or-n

(setq delete-by-moving-to-trash t)	; trash files instead of
					; permanant removal

;; Completion Preview
(use-package completion-preview
  :bind
  (:map completion-preview-active-mode-map
	("M-n" . completion-preview-next-candidate)
	("M-p" . completion-preview-prev-candidate))
  :hook
  (prog-mode . completion-preview-mode)
  (text-mode . completion-preview-mode)
  (comint-mode . completion-preview-mode)
  :custom
  (completion-preview-minimum-symbol-length 2))


