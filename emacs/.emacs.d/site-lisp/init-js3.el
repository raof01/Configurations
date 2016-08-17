;;;; load & configure js2-mode 
(autoload 'js3-mode "js3-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js3-mode))

(setq-default auto-complete-mode t)

(add-hook 'js3-mode-hook (lambda () (tern-mode t)))
(eval-after-load 'tern
   '(progn
      (require 'tern-auto-complete)
      (tern-ac-setup)))
 
(provide 'init-js3)
