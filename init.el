(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(yasnippet swift-mode lsp-ui lsp-treemacs lsp-sourcekit lsp-pyright lsp-ivy helm-lsp flycheck company)))
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

(defun require-package (package)
  (unless (package-installed-p package)
    (package-refresh-contents)
    (package-install package))
  (require package))

(load-theme 'wombat t)
(menu-bar-mode 0)

(require-package 'lsp-mode)
(add-hook 'c++-mode-hook #'lsp-deferred)

(require-package 'lsp-pyright)
(setq-default lsp-pyright-python-executable-cmd "python3")
(add-to-list 'lsp-disabled-clients 'pyls)
(add-hook 'python-mode-hook #'lsp-deferred)

(require-package 'lsp-sourcekit)
(eval-after-load 'lsp-mode
  (progn (require 'lsp-sourcekit)
	 (setq lsp-sourcekit-executable
	       "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/sourcekit-lsp")))
(require-package 'swift-mode)
(add-hook 'swift-mode-hook #'lsp-deferred)

(require-package 'lsp-treemacs)
(lsp-treemacs-sync-mode 1)
(setq-default treemacs-width 25)

(require-package 'company)
(add-hook 'after-init-hook 'global-company-mode)

(require-package 'yasnippet)
(yas-global-mode 1)

(require-package 'lsp-ui)
(require-package 'flycheck)
(require-package 'helm-lsp)
(require-package 'lsp-ivy)
