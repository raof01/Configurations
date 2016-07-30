;;;; load & configure js2-mode 
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
 
;;; espresso mode
(autoload 'espresso-mode "espresso")
 
(add-hook 'js2-mode-hook
	  (lambda ()
	    (yas-global-mode 1)))

(provide 'init-js2)
