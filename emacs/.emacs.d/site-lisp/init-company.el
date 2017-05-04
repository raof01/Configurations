
(cond ((string-equal system-type "darwin")
       (add-to-list 'load-path (concat "/Users/"
				       (user-real-login-name)
				       "/.emacs.d/elpa/company-0.9.0")))
      ((string-equal system-type "gnu/linux")
       (add-to-list 'load-path (concat "/home/"
				       (user-real-login-name)
				       "/.emacs.d/elpa/company-0.9.0")))
      ((string-equal system-type "windows-nt")
       (add-to-list 'load-path (concat "c:/Users/"
				       (user-real-login-name)
				       "/AppData/Roaming/.emacs.d/elpa/company-0.9.0"))))

(defun racket-mode-hook ()
  (when (and (stringp buffer-file-name)
             (string-match "\\.rkt\\'" buffer-file-name))
    (insert "OK")
    (orgtbl-mode)))

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
               'sh-mode-hook
	       'racket-mode-hook))
  (add-hook hook 'company-mode))

(provide 'init-company)
