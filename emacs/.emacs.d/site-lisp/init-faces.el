(setq-default cursor-type '(bar . 3))

(cond ((string-equal system-type "darwin")
       (custom-set-faces
	'(default ((t (:inherit nil :stipple nil :background "gray20" :foreground "white smoke" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 125 :width normal :foundry "nil" :family "Monaco")))))
       )
      ((string-equal system-type "windows-nt")
       (custom-set-faces
	'(default ((t (:inherit nil :stipple nil :background "SystemWindow" :foreground "SystemWindowText" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 120 :width normal :foundry "outline" :family "Consolas")))))
       )
      ((string-equal system-type "gnu/linux")
       (custom-set-faces
	'(cursor ((t (:background "dark red")))))))

(cond ((string-equal system-type "gnu/linux")
       '(custom-enabled-themes (quote (tango-dark)))))
(provide 'init-faces)
      
