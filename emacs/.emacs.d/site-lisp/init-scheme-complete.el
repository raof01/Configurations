(autoload 'scheme-smart-complete "scheme-complete" nil t)
(eval-after-load 'scheme
  '(define-key scheme-mode-map "\e\t" 'scheme-smart-complete))

(eval-after-load 'scheme
  '(define-key scheme-mode-map "\t" 'scheme-complete-or-indent))

(autoload 'scheme-get-current-symbol-info "scheme-complete" nil t)
(add-hook 'scheme-mode-hook
	  (lambda ()
	    (make-local-variable 'eldoc-documentation-function)
	    (setq eldoc-documentation-function 'scheme-get-current-symbol-info)
	    (eldoc-mode)))

(setq lisp-indent-function 'scheme-smart-indent-function)

(provide 'init-scheme-complete)

