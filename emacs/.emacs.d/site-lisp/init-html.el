(cond ((string-equal system-type "windows-nt")
       (setq browse-url-generic-program "C:/Program Files (x86)/Google/Chrome/Application/chrome.exe" browse-url-browser-function 'browse-url-generic))
      ((string-equal system-type "darwin")
       (setq browse-url-generic-program "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" browse-url-browser-function 'browse-url-generic)))

(add-hook 'html-mode-hook 'ac-html-enable)

(provide 'init-html)
