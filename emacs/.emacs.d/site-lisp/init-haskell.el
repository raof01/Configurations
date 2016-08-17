(cond ((string-equal system-type "darwin")
       (setq haskell-mode-path (concat "/Users/"
				       (user-real-login-name)
				       "/.emacs.d/elpa/haskell-mode-13.20.1")))
      ((string-equal system-type "windows-nt")
       (setq haskell-mode-path (concat "c:/Users/"
				       (user-real-login-name)
				       "/AppData/Roaming/.emacs.d/elpa/haskell-mode-13.20.1")))
      ((string-equal system-type "gnu/linux")
       (setq haskell-mode-path (concat "/home/"
				       (user-real-login-name)
				       "/.emacs.d/elpa/haskell-mode-13.20.1"))))

(add-to-list 'load-path haskell-mode-path)

(require 'haskell-mode)
(add-to-list 'Info-default-directory-list haskell-mode-path)
(require 'haskell)
(provide 'init-haskell)

