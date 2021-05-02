(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(multiple-cursors yasnippet lsp-ivy helm-lsp swift-mode lsp-sourcekit company lsp-python-ms lsp-ui lsp-treemacs flycheck)))
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

(require-package 'lsp-mode)
(add-hook 'c++-mode-hook #'lsp-deferred)

(require-package 'lsp-python-ms)
(setq lsp-python-ms-auto-install-server t)
(add-hook 'python-mode-hook #'lsp-deferred)

(require-package 'lsp-sourcekit)
(eval-after-load 'lsp-mode
  (progn (require 'lsp-sourcekit)
	 (setq lsp-sourcekit-executable
	       "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/sourcekit-lsp")))
(require-package 'swift-mode)
(add-hook 'swift-mode-hook #'lsp-deferred)

(require-package 'lsp-ui)
(require-package 'flycheck)
(require-package 'lsp-treemacs)
(require-package 'helm-lsp)
(require-package 'lsp-ivy)
(require-package 'company)
(require-package 'yasnippet)
(require-package 'multiple-cursors)
