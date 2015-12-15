
" LATEX/BIBTEX
au FileType tex set makeprg=pdflatex\ %:r\ &&\ bibtex\ %:r\ &&\ pdflatex\ %:r\ &&\ pdflatex\ %:r
