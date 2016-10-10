;; melpa
(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/")))
(package-initialize)

(setq package-archive-priorities
      '(("melpa-stable" . 20)
        ("marmalade" . 20)
        ("gnu" . 10)
        ("melpa" . 0)))

(provide 'init-melpa)
