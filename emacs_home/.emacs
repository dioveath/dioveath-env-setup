;;; .emacs --- This is Emacs init configuration file
;;; Commentary:
;;; Code:
;;; Saroj Rai @ Charicha 

;;; To see all key bindings in current buffer C-h b
;;; To see what a keybinding does C-h k and press command

(message "Message from loaded file .emacs")

(setq package-enable-at-startup nil)

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))



(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)


(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; CUSTOM THINGSSS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq inhibit-splash-screen t)
(transient-mark-mode t)
(require 'org)

(setq org-agenda-files '("~/org"))
(use-package org-bullets
  :ensure t
  :hook (org-mode . org-bullets-mode))
(setq org-hide-leading-stars t)


;; (add-hook 'after-init-hook 'org-agenda-list)
(setq initial-buffer-choice "~/startup.org")


(setq org-todo-keywords
      '((sequence "TODO" "IN-PROGRESS" "WAITING" "|" "DONE" "DELEGATED" "ABONDONED")))


(use-package doom-themes
  :ensure t
  :config
  (setq doom-themes-enable-bold t)
  (setq doom-themes-enable-italic t)
  (doom-themes-visual-bell-config)
  (doom-themes-org-config))

;; (doom-themes-treemacs-config)
;; (setq doom-themes-treemacs-theme "doom-atom")
;; (treemacs-load-theme "Default")


(require 'color)
(defun chc-load-theme()
  (set-face-attribute 'default nil :height 100 :weight 'normal)    
  ;; (set-background-color "black")
  ;; (set-face-background 'mode-line "dark slate gray")
  ;; (set-face-foreground 'mode-line "white")
  ;; (load-theme 'doom-solarized-dark-high-contrast t)
  
  (set-face-attribute 'default nil :height 95 :weight 'normal)
  (set-face-attribute 'default nil :height 105 :weight 'normal)
  (set-frame-font "InputMono Thin")
  (global-hl-line-mode t)

  ;; (set-face-background hl-line-face (color-lighten-name
  ;; 				     (face-attribute 'default :background) 10))

  ;; (let ((bg (face-attribute 'default :background)))
  ;;   (custom-set-faces
  ;;    `(company-tooltip ((t (:inherit default :background ,(color-lighten-name bg 2)))))
  ;;    `(company-scrollnbar-bg ((t (:background ,(color-lighten-name bg 10)))))
  ;;    `(company-scrollbar-fg ((t (:background ,(color-lighten-name bg 5)))))
  ;;    `(company-tooltip-selection ((t (:inherit font-lock-function-name-face))))
  ;;    `(company-tooltip-common ((t (:inherit font-lock-constant-face))))))
  
  (toggle-frame-fullscreen))


(if (daemonp)
    (add-hook 'after-make-frame-functions
	      (lambda (frame)
		(with-selected-frame frame
		  (chc-load-theme))))
  (chc-load-theme))


(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(icomplete-mode 1)
(ido-mode 1)

(show-paren-mode 1)
(setq show-paren-delay 0)
(electric-pair-mode 1)

(blink-cursor-mode 1)

(setq column-number-mode 1)
(fringe-mode 0)	


;; Windows Traversal
;; NOTE: couldn't find suitable keys for windowmove up &
;; down and no worries because less used things are those
;; (global-set-key (kbd "C-c i") 'windmove-up)
;; (global-set-key (kbd "C-c C-k") 'windmove-down)
(global-set-key (kbd "C-x C-j") 'windmove-left)
(global-set-key (kbd "C-x C-l") 'windmove-right)


;;;; Moving line up and down
(defun move-line-up()
  "Move up the current line."
  (interactive)
  (transpose-lines 1)
  (forward-line -2)
  (indent-according-to-mode))

(defun move-line-down()
  "Move down the current line."
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1)
  (indent-according-to-mode))

(global-set-key (kbd "C-S-I") 'move-line-up)
(global-set-key (kbd "C-S-K") 'move-line-down)


(defun chc-lsp-ui-doc-toggle-frame ()
  "Toggles the focus to lsp-ui-doc-frame"
  (interactive)
  (if (lsp-ui-doc--frame-visible-p) (lsp-ui-doc-focus-frame)
    (lsp-ui-doc-unfocus-frame)))

(global-set-key (kbd "C-c C-f") 'chc-lsp-ui-doc-toggle-frame)

;; Bright-red TODOs and NOTEes
(setq fixme-modes '(c++-mode c-mode emacs-lisp-mode web-mode java-mode javascript-mode php-mode bat-mode js2-mode rjsx-mode csharp-mode))

(make-face 'font-lock-fixme-face)
(make-face 'font-lock-todo-face)
(make-face 'font-lock-note-face)
(make-face 'font-lock-charicha)

(mapc (lambda (mode)
	(font-lock-add-keywords
	 mode
	 '(("\\<\\(FIXME\\):" 1 'font-lock-fixme-face t)
	   ("\\<\\(TODO\\):" 1 'font-lock-todo-face t)
	   ("\\<\\(NOTE\\):" 1 'font-lock-note-face t)
	   ("\\<\\(CharichaSoftwares\\)" 1 'font-lock-charicha t))))
      fixme-modes)

(modify-face 'font-lock-fixme-face "Red" nil nil t nil t nil nil)
(modify-face 'font-lock-todo-face "#ffff00" nil nil t nil t nil nil)
(modify-face 'font-lock-note-face "Green" nil nil t nil t nil nil)
(modify-face 'font-lock-charicha "#58fffd" nil nil t nil t nil nil)

;; (setq-default c-basic-offset 4)

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;;; END OF CUSTOM THINGSSS
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;;; IDE Like features
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package company
  :ensure t
  :config
  (progn
    (global-company-mode t)
    (setq company-tooltip-align-annotations t)
    (setq company-tooltip-idle-delay 0.1)
    ))

(use-package company-quickhelp
  :ensure t
  :after (company)
  :config
  (progn
    (company-quickhelp-mode t)
    (setq company-quickhelp-delay 0.1)
    (require 'color)
    (setq company-quickhelp-color-background "dark slate gray")
    (setq company-quickhelp-color-foreground "white")
    ))

(setq company-tooltip-align-annotations t)
(setq company-tooltip-idle-delay 0.1)
(setq company-quickhelp-delay 0.1)

(company-quickhelp-mode)
(eval-after-load 'company
  '(define-key company-active-map (kbd "C-c h") #'company-quickhelp-manual-begin))

(use-package which-key
  :ensure t
  :config (which-key-mode))


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;;; WEB MODE CONFIG THEME
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package emmet-mode
  :ensure t
  :hook ((web-mode . emmet-mode)
	 (rjsx-mode . emmet-mode)))


(use-package web-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.ejs\\'" . web-mode))  
  (add-to-list 'auto-mode-alist '("\\.php\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
  (setq web-mode-enable-current-element-highlight t)
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2))




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; SIDE BAR
;;;; Using lsp-treemacs
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package all-the-icons
  :ensure t
  :config (setq inhibit-compacting-font-caches t))


;; (use-package prettier-js
;;   :defer t
;;   :diminish prettier-js-mode
;;   :hook (((js2-mode rjsx-mode) . prettier-js-mode)))

(use-package json-mode
  :ensure t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; LSP Language Server Protocal
;; Flutter
;; CSharp - Progressing
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package lsp-mode
  :ensure t
  :bind-keymap
  (("C-c l" . lsp-command-map))

  :bind
  (("M-?" . 'lsp-find-references)
   ("M-p" . 'lsp-ui-peek-find-definitions))

  :custom
  (setq lsp-keymap-prefix "C-c l")
  :hook ((csharp-mode . lsp)
	 (rjsx-mode . lsp))
  (lsp-mode . lsp-enable-which-key-integration)
  :commands (lsp lsp-deferred))

(setq lsp-server-install-dir "c:/lsp")
(setq format-with-lsp nil)

(use-package lsp-ui
  :ensure t
  :defer t
  :init (setq lsp-ui-doc-enable t)
  :bind ("C-c C-u" . 'lsp-ui-doc-hide))

(use-package lsp-treemacs
  :ensure t
  :defer t
  :bind (("C-x C-n" . treemacs))
  :config (treemacs-resize-icons 20))


(use-package lsp-dart
  :ensure t
  :hook (dart-mode . lsp))

(use-package hover
  :ensure t)

(use-package flutter
  :ensure t
  :after dart-mode
  :bind (:map dart-mode-map
	      ("C-M-x" . #'flutter-run-or-hot-reload)))

(use-package yasnippet
  :ensure t
  :config (yas-global-mode))

(use-package yasnippet-snippets
  :ensure t)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; RJSX-MODE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package rjsx-mode
  :ensure t
  :mode("\\.js\\'"
	"\\.jsx\\'"
	"\\.ts\\'"
	"\\.tsx\\'")
  :hook (rjsx-mode . lsp-deferred)
  :config
  (setq js2-basic-offset 2
	js-jsx-indent-level 2
	js-indent-level 2))

(use-package add-node-modules-path
  :ensure t
  :defer t
  :hook (((js2-mode rjsx-mode) . add-node-modules-path)))

(setq lsp-eslint-server-command 
      '("node"
	"C:/Users/raisa/.vscode/extensions/dbaeumer.vscode-eslint-2.2.2/server/out/eslintServer.js"	
	"--stdio"))


(use-package typescript-mode
  :ensure t
  :after lsp-mode
  :mode ("\.ts$")
  :hook (typescript-mode . lsp-deferred)
  :config
  (setq typescript-indent-level 4))



(use-package helm-lsp
  :ensure t
  :init (helm-mode t)
  :bind (([remap execute-extended-command] . helm-M-x)
	 ("C-x C-f" . helm-find-files)
	 ("C-x b" . helm-mini)
	 ("C-c C-l" . helm-lsp-code-actions)))

;; (bind-key* (kbd "C-c C-l") 'helm-lsp-code-actions)

(use-package helm-xref
  :ensure t)

(setq gc-cons-threshold 100000000)
(setq read-process-output-max (* 1024 1024))
(setq lsp-log-io nil)
(setq create-lockfiles nil)

(setq completion-styles '(flex))




;; ;; don't know how the directories are written
(with-eval-after-load 'lsp-mode
  (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]\\.Temp\\'"))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Remote Editing with TRAMP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (use-package helm-tramp
;;   :ensure t
;;   :bind ("C-c C-s" . helm-tramp))
;; (setq tramp-debug-buffer t)
;; (setq tramp-verbose 10)
;; (setq tramp-auto-save-directory "~/tramp-temp")


(use-package multiple-cursors
  :ensure t
  :bind
  ("C-c RET" . 'mc/edit-lines)
  ("C->" . 'mc/mark-next-like-this)
  ("C-<" . 'mc/mark-previous-like-this)
  ("C-c C-<" . 'mc/mark-all-like-this))


;; Setting it overidding every mode keys
;; NOTE: Some are not working
(bind-key* (kbd "C-c RET") 'mc/edit-lines)
(bind-key* (kbd "C->") 'mc/mark-next-like-this)
(bind-key* (kbd "C-<") 'mc/mark-previous-like-this)
(bind-key* (kbd "C-c C-<") 'mc/mark-all-like-this)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Python IDE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (use-package python-mode
;;   :ensure t
;;   :hook (python-mode . lsp-deferred))

;; (use-package lsp-python-ms
;;   :ensure t
;;   :init (setq lsp-python-ms-auto-install-server t)
;;   :hook (python-mode . (lambda ()
;;                           (require 'lsp-python-ms)
;;                           (lsp-deferred))))  ; or lsp-deferred



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; TailwindCSS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package lsp-tailwindcss
  :ensure t
  :init
  (setq lsp-tailwindcss-experimental-class-regex ["tw`([^`]*)" "tw=\"([^\"]*)" "tw={\"([^\"}]*)" "tw\\.\\w+`([^`]*)" "tw\\(.*?\\)`([^`]*)"])
  (setq lsp-tailwindcss-add-on-mode t))


	 


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Java
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (require 'lsp-java)
;; (add-hook 'java-mode-hook #'lsp)

;; (use-package lsp-java
;;   :ensure t
;;   :config (add-hook 'java-mode-hook 'lsp))

;; (setq lsp-java-jdt-download-url  "https://download.eclipse.org/jdtls/milestones/0.57.0/jdt-language-server-0.57.0-202006172108.tar.gz")





;; (use-package copilot
;;   :straight (:host github :repo "zerolfx/copilot.el"
;;                    :files ("dist" "copilot.el"))
;;   :ensure t)

; complete by copilot first, then company-mode
;; (defun my-tab ()
;;   (interactive)
;;   (or (copilot-accept-completion)
;;       (company-indent-or-complete-common nil)))

; modify company-mode behaviors
;; (with-eval-after-load 'company
;;   ; disable inline previews
;;   (delq 'company-preview-if-just-one-frontend company-frontends)
;;   ; enable tab completion
;;   (define-key company-mode-map (kbd "<tab>") 'my-tab)
;;   (define-key company-mode-map (kbd "TAB") 'my-tab)
;;   (define-key company-active-map (kbd "<tab>") 'my-tab)
;;   (define-key company-active-map (kbd "TAB") 'my-tab))

;; (use-package copilot
;;   :straight (:host github :repo "zerolfx/copilot.el"
;; 		   :files ("dist" "copilot.el"))
;;   :ensure t
;;   :hook (prog-mode . copilot-mode))


;; Apheleia Formatter
(straight-use-package 'apheleia)
