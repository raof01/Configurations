(setq octave-program "octave")

(cond ((string-equal system-type "darwin")
       (setq octave-program "/Applications/Octave.app/Contents/Resources/usr/bin/octave"))
      ((string-equal system-type "windows-nt")
       (setq octave-program "d:/Octave/Octave-4.0.3/bin/octave-cli.exe")))

(custom-set-variables
 '(inferior-octave-program octave-program)
 '(inferior-octave-prompt-read-only t))

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

(provide 'init-octave)
