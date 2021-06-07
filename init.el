(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-export-backends '(ascii html icalendar latex md odt))
 '(package-selected-packages
   '(multiple-cursors cmake-mode sbt-mode lsp-metals rust-mode lsp-treemacs treemacs counsel yasnippet swift-mode lsp-ui lsp-sourcekit lsp-pyright lsp-ivy flycheck company)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

;; Code should be implemented for auto-upgrading packages
(when (not package-archive-contents)
  (package-refresh-contents))

;; download and install `package` if not downloaded yet
(defun require-package (package)
  (unless (package-installed-p package)
    (package-install package))
  (require package))

;; a custom theme provided by emacs by default
(load-theme 'wombat t)
;; disable the menu bar on the top of a window
;; (menu-bar-mode -1)
;; set the font for graphical emacs
(set-face-attribute 'default nil :height 250)
(set-face-attribute 'fixed-pitch nil :family 'unspecified :inherit 'default)
(setq-default line-spacing 5)
;;(add-to-list 'default-frame-alist '(font . "SF Mono 23"))
;; do not display the ugly top tool bar
(tool-bar-mode -1)
;; do not show scroll bar
(scroll-bar-mode -1)
;; only spaces when pressing tabs
(setq-default indent-tabs-mode nil)

;; an emacs client for the language server protocol.
;; includes a number of clients for different PLs, but some of them should
;; be installed separately, e.g. lsp-pyright
(require-package 'lsp-mode)

;; enter lsp at c++ mode
(add-hook 'c++-mode-hook #'lsp-deferred)

;; a python lsp client of emacs for pyright python server
(require-package 'lsp-pyright)
(setq-default lsp-pyright-python-executable-cmd "python3")
;; lsp-mode provides a default client for pyls server, and this cmd disables it
;; so pyright is of a greater priority to be loaded
(defvar lsp-disabled-clients)
(add-to-list 'lsp-disabled-clients 'pyls)
(add-hook 'python-mode-hook #'lsp-deferred)

;; lsp client for sourcekit server, which provides lsp features for Swift
(require-package 'lsp-sourcekit)
(eval-after-load 'lsp-mode
  (progn (require 'lsp-sourcekit)
	 (setq-default lsp-sourcekit-executable
		       ;; path for the sourcekit server
		       "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/sourcekit-lsp")))
(require-package 'swift-mode)
(add-hook 'swift-mode-hook #'lsp-deferred)

;; tree-based file explorer
(require-package 'treemacs)
(setq-default treemacs-width 22)
(setq-default treemacs--width-is-locked nil)

(require-package 'lsp-treemacs)
;; sync treemacs project with lsp workspace
(lsp-treemacs-sync-mode 1)

;; auto-completion in code
(require-package 'company)
;; enable company completion globally
(add-hook 'after-init-hook 'global-company-mode)

;; for function templates expansion
(require-package 'yasnippet)
;; enable yas globally
(yas-global-mode 1)

;; based on ivy, a package for emacs completion
(require-package 'counsel)
;; prevent double-tabs publishing commands
(defvar ivy-minibuffer-map) ; a declaration to get rid of warnings
(define-key ivy-minibuffer-map (kbd "TAB") 'ivy-partial)
;; ivy is for global commands; can be considered a modification of emacs internal
;; counsel is a client which implements user-oriented commands based on ivy
(ivy-mode 1)
(counsel-mode 1)
;; disable this candidate index
(setq-default ivy-count-format "")
;; e.g. M-x after M-x is allowed
(setq-default enable-recursive-minibuffers t)
(minibuffer-depth-indicate-mode 1)
;; make recently-visited files as candidates
(setq-default ivy-use-virtual-buffers t)
;; remove the leading regex '^' for all commands
(setq-default ivy-initial-inputs-alist nil)

;; lsp integration with ivy; enables finding some var/funcs in an lsp workspace
(require-package 'lsp-ivy)

;; rust-mode support.
;; lsp-rust client is provided by lsp-mode by default.
;; rust language server rls is installed via rustup
(require-package 'rust-mode)
(add-hook 'rust-mode-hook #'lsp-deferred)

;; scala-mode support (a dependecy of lsp-metals)
(require-package 'scala-mode)
;; scala build tool
(require-package 'sbt-mode)
;; emacs client to scala's language server: metals; server installed via lsp-server-install
(require-package 'lsp-metals)
(add-hook 'scala-mode-hook #'lsp-deferred)

;;; below are packages I currently have few knowledge of
;; cmake-mode
(require-package 'cmake-mode)

;; to display code analysis results by lsp
(require-package 'lsp-ui)

;; code analysis tool
(require-package 'flycheck)

;; DAP: a sister protocol of LSP
(require-package 'dap-mode)

;; multiple cursors
(require-package 'multiple-cursors)
