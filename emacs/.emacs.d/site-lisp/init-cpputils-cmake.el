
(cond ((string-equal system-type "darwin")
       (add-to-list 'load-path (concat "/Users/"
				       (user-real-login-name)
				       "/.emacs.d/elpa/cpputils-cmake-5.5")))
      ((string-equal system-type "gnu/linux")
       (add-to-list 'load-path (concat "/home/"
				       (user-real-login-name)
				       "/.emacs.d/elpa/cpputils-cmake-5.5")))
      ((string-equal system-type "windows-nt")
       (add-to-list 'load-path (concat "c:/Users/"
				       (user-real-login-name)
				       "/AppData/Roaming/.emacs.d/elpa/cpputils-cmake-5.5"))))

(cond ((string-equal system-type "darwin")
       (setq cmake-mode-path  "/usr/local/Cellar/cmake/3.5.2/share/emacs/site-lisp/cmake/cmake-mode.el"))
      ((string-equal system-type "gnu/linux")
       (setq cmake-mode-path "/usr/share/cmake-3.5/editors/emacs/cmake-mode.el"))
      ((string-equal system-type "windows-nt")
       (setq cmake-mode-path "D:/Program Files (x86)/CMake/share/cmake-3.4/editors/emacs/cmake-mode.el")))

(setq auto-mode-alist
	  (append
	   '(("CMakeLists\\.txt\\'" . cmake-mode))
	   '(("\\.cmake\\'" . cmake-mode))
	   auto-mode-alist))

(autoload 'cmake-mode cmake-mode-path t)

(require 'cpputils-cmake)
(add-hook 'c-mode-common-hook
          (lambda ()
            (if (derived-mode-p 'c-mode 'c++-mode)
                (cppcm-reload-all)
              )))

(provide 'init-cpputils-cmake)
