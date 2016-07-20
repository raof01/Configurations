
(if (string-equal system-type "darwin")
    (add-to-list 'load-path "/Users/raof01/.emacs.d/elpa/cpputils-cmake-20160515.103")
  )

(setq cmake-mode-path  "/usr/local/Cellar/cmake/3.5.2/share/emacs/site-lisp/cmake/cmake-mode.el")

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
