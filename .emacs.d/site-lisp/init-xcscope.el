(require 'xcscope)
(cond ((string= system-type "darwin")
       (setq cscope-program "/usr/local/bin/cscope"))
      ((string= system-type "windows-nt")
       (setq cscope-program "cscope")))
(add-hook 'csharp-mode-hook (function cscope-minor-mode))
(provide 'init-xcscope)

