(setq haskell-mode-path (concat "/Users/"
				(user-real-login-name)
				"/.emacs.d/elpa/haskell-mode-13.20"))

(cond ((string-equal system-type "darwin")
       (add-to-list 'load-path haskell-mode-path))
      ((string-equal system-type "windows-nt")
       (add-to-list 'load-path "")))

(require 'haskell-mode)
(add-to-list 'Info-default-directory-list haskell-mode-path)
(require 'haskell)
(provide 'init-haskell)

