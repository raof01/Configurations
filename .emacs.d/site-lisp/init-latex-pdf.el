(setq latex-pdf-process (quote
			 ("pdflatex -interaction nonstopmode -output-directory %o %f" "pdflatex -interaction nonstopmode -output-directory %o %f" "pdflatex -interaction nonstopmode -output-directory %o %f")))

(if (string-equal system-type "darwin")
      (setq latex-pdf-process (quote
			       ("/Library/TeX/texbin/pdflatex -interaction=nonstopmode -output-directory=%o %f" "/Library/TeX/texbin/pdflatex -interaction=nonstopmode -output-directory=%o %f" "/Library/TeX/texbin/pdflatex -interaction=nonstopmode -output-directory=%o %f"))))

(custom-set-variables
 '(org-latex-pdf-process latex-pdf-process))

(provide 'init-latex-pdf)

