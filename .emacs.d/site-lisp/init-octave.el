(setq octave-program "octave")

(if (string-equal system-type "darwin")
    (setq octave-program "/usr/local/octave/3.8.0/bin/octave")
  )

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
