;;;; load & configure js2-mode 
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
 
;;; espresso mode
(autoload 'espresso-mode "espresso")
 
(add-hook 'js2-mode-hook
	  (lambda ()
	    (yas-global-mode 1)))

(cond ((string-equal system-type "windows-nt")
       (setq browse-url-generic-program "C:/Program Files (x86)/Google/Chrome/Application/chrome.exe" browse-url-browser-function 'browse-url-generic)))

(provide 'init-js2)
