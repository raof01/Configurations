
;; local variables
(setq octave-program "octave")
(setq latex-pdf-process (quote
			 ("pdflatex -interaction nonstopmode -output-directory %o %f" "pdflatex -interaction nonstopmode -output-directory %o %f" "pdflatex -interaction nonstopmode -output-directory %o %f")))

;; Platform specific settings
(if (string-equal system-type "darwin")
    (progn
      (add-to-list 'load-path "/Users/raof01/.emacs.d/site-lisp")
      (add-to-list 'load-path "/Users/raof01/.emacs.d/elpa/company-0.9.0")
      (setq octave-program "/usr/local/octave/3.8.0/bin/octave")
      (setq latex-pdf-process (quote
			       ("/Library/TeX/texbin/pdflatex -interaction=nonstopmode -output-directory=%o %f" "/Library/TeX/texbin/pdflatex -interaction=nonstopmode -output-directory=%o %f" "/Library/TeX/texbin/pdflatex -interaction=nonstopmode -output-directory=%o %f"))
	    )
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
 '(inferior-octave-program octave-program)
 '(inferior-octave-prompt-read-only t)
 '(org-latex-pdf-process latex-pdf-process))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "gray20" :foreground "white smoke" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 125 :width normal :foundry "nil" :family "Monaco")))))

;; Octave
(autoload 'octave-mode "octave-mod" nil t)
(setq auto-mode-alist
      (cons '("\\.m$" . octave-mode) auto-mode-alist))
(add-hook 'octave-mode-hook
          (lambda ()
            (abbrev-mode 1)
            (auto-fill-mode 1)
            (if (eq window-system 'x)
                (font-lock-mode 1))))
(require 'octave-mod)
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
