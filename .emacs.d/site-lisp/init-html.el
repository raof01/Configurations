(cond ((string-equal system-type "windows-nt")
       (setq browse-url-generic-program "C:/Program Files (x86)/Google/Chrome/Application/chrome.exe" browse-url-browser-function 'browse-url-generic)))

(add-hook 'html-mode-hook 'ac-html-enable)

(provide 'init-html)
