(add-to-list 'load-path "~/.emacs.d/site-lisp")

(require 'init-melpa)

;; Global settings
(setq inhibit-startup-message t)
(tool-bar-mode -1)
(setq backup-inhibited t)

(custom-set-variables
 '(c-basic-offset 4)
 '(c-default-style
   (quote
    ((c-mode . "linux")
     (c++-mode . "linux")
     (java-mode . "java"))))
 '(ns-right-alternate-modifier (quote control))
 '(kill-whole-line t))

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

(require 'init-faces)

;; Flymake
(require 'flymake)

(require 'init-octave)
(require 'init-latex-pdf)
(require 'init-cpputils-cmake)
(require 'init-company)
(require 'init-org)
(require 'init-haskell)
(require 'init-xcscope)
(require 'init-js2)
