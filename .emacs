(add-to-list 'load-path ".emacs.d/site-lisp")


;; Platform specific settings
(if (string-equal system-type "darwin")
    (progn
      (add-to-list 'load-path "/Users/raof01/.emacs.d/elpa/company-0.9.0")
      (add-to-list 'load-path "/Users/raof01/.emacs.d/elpa/cpputils-cmake-20160515.103")
      (setq cmake-mode-path "/usr/local/Cellar/cmake/3.5.2/share/emacs/site-lisp/cmake/cmake-mode.el")
      )
  )

;; Global settings
(setq inhibit-startup-message t)
(tool-bar-mode -1)
(setq backup-inhibited t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(c-basic-offset 4)
 '(c-default-style
   (quote
    ((c-mode . "linux")
     (c++-mode . "linux")
     (java-mode . "java"))))
 '(kill-whole-line t)
)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "gray20" :foreground "white smoke" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 125 :width normal :foundry "nil" :family "Monaco")))))

(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

;; Window number
(require 'window-number)
(window-number-mode)
(window-number-meta-mode)

(desktop-save-mode 1)
;(require 'highlight)
;(show-paren-mode 1)

;; Company mode
(require 'company)
(dolist (hook (list
               'emacs-lisp-mode-hook
               'lisp-mode-hook
               'lisp-interaction-mode-hook
               'scheme-mode-hook
               'c-mode-common-hook
               'python-mode-hook
               'haskell-mode-hook
               'asm-mode-hook
               'emms-tag-editor-mode-hook
               'sh-mode-hook))
  (add-hook hook 'company-mode))

;; Flymake
(require 'flymake)
;;(require 'rfringe)

;; CMake
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

;; melpa
(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/")))
(package-initialize)

(require 'init-octave)
(require 'init-latex-pdf)
