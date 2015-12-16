
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => TeX specific
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au FileType tex set makeprg=pdflatex\ %:r\ &&\ bibtex\ %:r\ &&\ pdflatex\ %:r\ &&\ pdflatex\ %:r

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Python specific
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" get virtualenv support
if has('python')
py << EOF
import os.path
import sys
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    sys.path.insert(0, project_base_dir)
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF
endif

" PEP8-y whitespace options
au BufNewFile,BufRead *.py set tabstop=4
au BufNewFile,BufRead *.py set softtabstop=4
au BufNewFile,BufRead *.py set shiftwidth=4
au BufNewFile,BufRead *.py set textwidth=79
au BufNewFile,BufRead *.py set expandtab
au BufNewFile,BufRead *.py set autoindent
au BufNewFile,BufRead *.py set fileformat=unix

" Good default fold positions
autocmd BufWinEnter *.py setlocal foldexpr=SimpylFold(v:lnum) foldmethod=expr
autocmd BufWinLeave *.py setlocal foldexpr< foldmethod<

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Web specific
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au BufNewFile,BufRead *.js, *.html, *.css set tabstop=2
au BufNewFile,BufRead *.js, *.html, *.css set softtabstop=2
au BufNewFile,BufRead *.js, *.html, *.css set shiftwidth=2
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh']


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => org-mode specific
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au BufNewFile,BufRead *.org set textwidth=0

