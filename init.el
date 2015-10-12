(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector (vector "#c5c8c6" "#cc6666" "#b5bd68" "#f0c674" "#81a2be" "#b294bb" "#8abeb7" "#1d1f21"))
 '(auto-save-default nil)
 '(backup-inhibited t t)
 '(column-number-mode t)
 '(custom-safe-themes (quote ("628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "82d2cac368ccdec2fcc7573f24c3f79654b78bf133096f9b40c20d97ec1d8016" "1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" default)))
 '(delete-selection-mode t)
 '(fci-rule-color "#282a2e")
 '(hl-paren-colors (quote ("#d54e53" "#e78c45" "#e7c547" "#b9ca4a" "#70c0b1" "#7aa6da" "#c397d8")))
 '(inhibit-startup-screen t)
 '(initial-scratch-message nil)
 '(menu-bar-mode nil)
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil)
 '(vc-annotate-background nil)
 '(vc-annotate-color-map (quote ((20 . "#cc6666") (40 . "#de935f") (60 . "#f0c674") (80 . "#b5bd68") (100 . "#8abeb7") (120 . "#81a2be") (140 . "#b294bb") (160 . "#cc6666") (180 . "#de935f") (200 . "#f0c674") (220 . "#b5bd68") (240 . "#8abeb7") (260 . "#81a2be") (280 . "#b294bb") (300 . "#cc6666") (320 . "#de935f") (340 . "#f0c674") (360 . "#b5bd68"))))
 '(vc-annotate-very-old-color nil)
 '(cursor-in-non-selected-windows nil))

;; Package.el customization
(require 'package)
(package-initialize)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
;;(add-to-list 'package-archives '("melpa-stable" . "http://melpa-stable.milkbox.net/packages") t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
;;(add-to-list 'package-pinned-packages '(cider . "melpa-stable") t)

;; Ensure installed packages
(defvar my-packages '(auto-complete
                      cider
                      clojure-mode
                      color-theme
                      color-theme-sanityinc-tomorrow
                      csv-mode
                      dash
                      epl
                      erlang
                      haskell-mode
                      highlight-parentheses
                      magit
                      markdown-mode
                      org
                      paredit
                      pkg-info
                      rainbow-delimiters
                      s
                      smart-tab
                      smartparens))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

;; Enable spell-checking comments in all prog modes
;; (add-hook 'prog-mode-hook 'flyspell-prog-mode)

;; Enable global auto revert mode
(global-auto-revert-mode t)

;; Enable ido mode
(ido-mode t)

;; Org-latex export
(require 'ox-latex)
(add-to-list 'org-latex-packages-alist '("" "minted"))
(setq org-latex-listings 'minted)

(setq org-latex-pdf-process
      '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))

;; Auto-complete
(require 'auto-complete-config)
(ac-config-default)

;; Smartparens
(require 'smartparens-config)
(add-hook 'html-mode-hook 'smartparens-mode)
(add-hook 'html-mode-hook 'show-smartparens-mode)
(define-key sp-keymap (kbd "C-<right>") 'sp-forward-slurp-sexp)
(define-key sp-keymap (kbd "C-<left>") 'sp-forward-barf-sexp)

;; Paredit
(add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)
(add-hook 'scheme-mode-hook 'paredit-mode)
(add-hook 'clojure-mode-hook 'paredit-mode)
(add-hook 'cider-repl-mode-hook 'paredit-mode)

;; Highlight-parentheses
(require 'highlight-parentheses)
(define-globalized-minor-mode global-highlight-parentheses-mode
  highlight-parentheses-mode
  (lambda ()
    (highlight-parentheses-mode t)))

;; Hook on parenthesis highlight
(add-hook 'emacs-lisp-mode-hook 'highlight-parentheses-mode)
(add-hook 'scheme-mode-hook 'highlight-parentheses-mode)
(add-hook 'clojure-mode-hook 'highlight-parentheses-mode)
(add-hook 'cider-repl-mode-hook 'highlight-parentheses-mode)

;; CIDER
(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
(setq cider-popup-stacktraces nil)
(setq cider-repl-use-clojure-font-lock t)
(setq nrepl-log-messages t)

;; Haskell mode
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)

;; Enable flyspell on text-modes
(add-hook 'text-mode-hook 'turn-on-flyspell)

;; Super Tab
(require 'smart-tab)
(global-smart-tab-mode 1)

;; APPEARANCE

;; Set color-theme
(require 'color-theme)
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     (color-theme-sanityinc-tomorrow-night)))

(set-face-attribute 'default nil :height 120)
;; (set-cursor-color "white")
(set-face-background 'cursor "white")
(blink-cursor-mode 1)
;; (set-face-attribute 'cursor nil :background "white")
(setq-default indent-tabs-mode nil)
(setq tab-width 2)
(setq-default truncate-lines t)

;; Set parentheses color
(defface esk-paren-face
  '((((class color) (background dark))
     (:foreground "grey40"))
    (((class color) (background light))
     (:foreground "grey55")))
  "Face used to dim parentheses."
  :group 'starter-kit-faces)

(font-lock-add-keywords 'clojure-mode
                        '(("(\\|)" . 'esk-paren-face)))

;; Autoload markdown-mode on certain files
(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; Configure org-babel
(require 'org)
(require 'ob-clojure)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((sh . t)
   (emacs-lisp . t)
   (clojure . t)))

(setq org-babel-clojure-backend 'cider)
(require 'cider)

(setq org-edit-src-content-indentation 0
      org-src-tab-acts-natively t
      org-confirm-babel-evaluate nil
      org-src-fontify-natively t)

(add-to-list 'org-babel-tangle-lang-exts '("clojure" . "clj"))

(defvar org-babel-default-header-args:clojure
  '((:results . "silent") (:tangle . "yes")))

;; (defun org-babel-execute:clojure (body params) (lisp-eval-string body) "Done!")

;; (provide 'ob-clojure)

;; Enable dired buffer replacing
(put 'dired-find-alternate-file 'disabled nil)

;; Custom key bindings for paredit
(eval-after-load 'paredit
  '(progn
     (define-key paredit-mode-map (kbd "<M-up>") 'paredit-backward-up)
     (define-key paredit-mode-map (kbd "<M-down>") 'paredit-forward-down)))

;; Custom identation and cleanup functions
(defun untabify-buffer ()
  (interactive)
  (untabify (point-min) (point-max)))

(defun indent-buffer ()
  (interactive)
  (indent-region (point-min) (point-max)))

(defun cleanup-buffer ()
  "Perform a bunch of operations on the whitespace content of a buffer."
  (interactive)
  (indent-buffer)
  (untabify-buffer)
  (delete-trailing-whitespace))

;; Google function
(defun google ()
  "Google the selected region if any, display a query prompt otherwise"
  (interactive)
  (browse-url
   (concat
    "http://www.google.com/search?ie=utf-8&oe=utf-8&q="
    (url-hexify-string (if mark-active
                           (buffer-substring (region-beginning)
                                             (region-end))
                         (read-string "Google: "))))))

;; Find init file function
(defun find-user-init-file ()
  "Edit the `user-init-file', in another window."
  (interactive)
  (find-file-other-window user-init-file))

;; Global keybindings
(global-set-key (kbd "C-c n") 'cleanup-buffer)
(global-set-key (kbd "C-c g") 'google)
(global-set-key (kbd "C-c i") 'find-user-init-file)

(defun smarter-move-beginning-of-line (arg)
  "Move point back to indentation of beginning of line.
   Move point to the first non-whitespace character on this line.
   If point is already there, move to the beginning of the line.
   Effectively toggle between the first non-whitespace character and
   the beginning of the line.
   If ARG is not nil or 1, move forward ARG - 1 lines first.  If
   point reaches the beginning or end of the buffer, stop there."
  (interactive "^p")
  (setq arg (or arg 1))

  ;; Move lines first
  (when (/= arg 1)
    (let ((line-move-visual nil))
      (forward-line (1- arg))))

  (let ((orig-point (point)))
    (back-to-indentation)
    (when (= orig-point (point))
      (move-beginning-of-line 1))))

;; remap C-a to `smarter-move-beginning-of-line'
(global-set-key [remap move-beginning-of-line]
                'smarter-move-beginning-of-line)

;; Set scheme interpreter to chicken-scheme
(setq scheme-program-name "csi -:c")

;; Set tramp default method to be ssh
(setq tramp-default-method "ssh")
