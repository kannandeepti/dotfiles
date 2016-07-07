
augroup filespecificconfig

"{{{ => TeX specific

" this makeprg should execute pdflatex,bibtex,pdflatex,pdflatex on the current
" file, unless bibtex fails, in which case it will simply execute two pdflatex's
" in a row
au FileType tex set makeprg=pdflatex\ %:r\ &&\ bibtex\ %:r\ &&\ pdflatex\ %:r\ &&\ pdflatex\ %:r\ \\\|\\\|\ pdflatex\ %:r
"}}}

"{{{ => Python specific

" get virtualenv support
if has('python')
py << EOF
import os.path
import sys
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    sys.path.insert(0, project_base_dir)
    execfile('/home/bbeltr1/.vim/venv_activate.py', dict(venv_directory=project_base_dir))
EOF
endif

" PEP8-y whitespace options
au filetype python set tabstop=4
au filetype python set softtabstop=4
au filetype python set shiftwidth=4
au filetype python set textwidth=79
au filetype python set expandtab
au filetype python set autoindent
au filetype python set fileformat=unix

" Good default fold positions
"autocmd BufWinEnter *.py setlocal foldexpr=SimpylFold(v:lnum) foldmethod=expr
"autocmd BufWinLeave *.py setlocal foldexpr< foldmethod<

" }}}

"{{{ => Web specific
"au BufNewFile,BufRead *.js, *.html, *.css set tabstop=2
"au BufNewFile,BufRead *.js, *.html, *.css set softtabstop=2
"au BufNewFile,BufRead *.js, *.html, *.css set shiftwidth=2
au BufNewFile,BufReadPost *.md set filetype=markdown
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh']

"}}}

"{{{ => org-mode specific
au BufNewFile,BufRead *.org set textwidth=0
" automatically commit and rsync up/down on read/write of shared org files
au BufReadPost /home/bbeltr1/developer/org-mode-notes/*.org OrgSafelyPullRemoteChanges
au BufWritePost /home/bbeltr1/developer/org-mode-notes/*.org OrgUnSafelyPushChangesToRemote
"}}}

"{{{ => vimrc specific
au FileType vim set foldmethod=marker
"}}}
"

augroup END


command! OrgSafelyPullRemoteChanges call <SID>org_pull_from_origin()
function! <SID>org_pull_from_origin()
    if executable('git')
        let l:oldpath = getcwd()
        cd %:p:h
        silent !git commit -am 'auto'
        echo "Attempting to pull down latest version of file from org-database."
        silent !rsync -a bbeltr1@brunobeltran.org:/home/bbeltr1/developer/org-mode-notes/ /home/bbeltr1/developer/org-mode-notes/
        if v:shell_error == 0
            echo "SUCCESS!"
        else
            echo "FAILED to pull from database."
        endif
        execute('cd'.l:oldpath)
    endif
endfunction

" push our changes into the stash, pull down the remote's changes, and commit
" if they exist, then pop our changes over the remote's changes, selecting our changes
" where applicable, and make a commit that is then rsync'd up
" to the remote. this way, nothing is lost, but our local changes are always
" preferred
command! OrgUnSafelyPushChangesToRemote call <SID>org_push_to_origin()
function! <SID>org_push_to_origin()
    if exists(':Gwrite')
        let l:oldpath = getcwd()
        cd %:p:h
        silent !git commit -am 'auto'
        if v:shell_error == 0
            echo "Attempting to copy your changes to org-database."
            !rsync -a --delete --exclude '.*.swp' /home/bbeltr1/developer/org-mode-notes/ bbeltr1@brunobeltran.org:/home/bbeltr1/developer/org-mode-notes/
            if v:shell_error == 0
                echo "SUCCESS!"
            endif
        else
            echo "Nothing to commit or commit failed, not writing to database."
        endif
        execute('cd'.l:oldpath)
    endif
endfunction
