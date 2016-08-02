"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Automagic File Open/Close Stuff
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" This stuff makes loading really slow since
" loadview is so slow (documented in :help loadview)

" set viewdir=~/.vim/temp_dirs/viewdir
" set viewoptions-=options
" augroup vimrc
"     autocmd BufWinLeave *
"     \   if expand('%') != '' && &buftype !~ 'nofile'
"     \|      mkview
"     \|  endif
"     autocmd BufWinEnter *
"     \   if expand('%') != '' && &buftype !~ 'nofile'
"     \|      silent! loadview
"     \|  endif
" augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => GUI related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set font according to system
if has("gui_running")
    if has("gui_gtk2")
        set guifont=Inconsolata\ 12
    elseif has("gui_macvim")
        set guifont=Menlo\ Regular:h14
    elseif has("gui_win32")
        set guifont=Consolas:h11:cANSI
    endif
else
    if has("mac") || has("macunix")
        set guifont=Source\ Code\ Pro:h15,Menlo:h15
    elseif has("win16") || has("win32")
        set guifont=Source\ Code\ Pro:h12,Bitstream\ Vera\ Sans\ Mono:h11
    elseif has("linux")
        set guifont=Source\ Code\ Pro:h12,Bitstream\ Vera\ Sans\ Mono:h11
    elseif has("unix")
        set guifont=Monospace\ 11
    endif
endif

" Open MacVim in fullscreen mode
if has("gui_macvim")
    set fuoptions=maxvert,maxhorz
    au GUIEnter * set fullscreen
endif

" Disable scrollbars (real hackers don't use scrollbars for navigation!)
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Turn persistent undo on
"    means that you can undo even when you close a buffer/VIM
if empty(glob('~/.vim/temp_dirs/undodir'))
    call mkdir('~/.vim/temp_dirs/undodir', 'p')
endif
set undodir=~/.vim/temp_dirs/undodir
set undofile

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Command mode related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Smart mappings on the command line
"cno $h e ~/
"cno $d e ~/Desktop/
"cno $j e ./
"cno $c e <C-\>eCurrentFileDir("e")<cr>

" $q is super useful when browsing on the command line
" it deletes everything until the last slash
"cno $q <C-\>eDeleteTillSlash()<cr>


" Map ½ to something useful
"map ½ $
"cmap ½ $
"imap ½ $


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Parenthesis/bracket
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"vnoremap $1 <esc>`>a)<esc>`<i(<esc>
"vnoremap $2 <esc>`>a]<esc>`<i[<esc>
"vnoremap $3 <esc>`>a}<esc>`<i{<esc>
"vnoremap $$ <esc>`>a"<esc>`<i"<esc>
"vnoremap $q <esc>`>a'<esc>`<i'<esc>
"vnoremap $e <esc>`>a"<esc>`<i"<esc>

" Map auto complete of (, ", ', [
"inoremap $1 ()<esc>i
"inoremap $2 []<esc>i
"inoremap $3 {}<esc>i
"inoremap $4 {<esc>o}<esc>O
"inoremap $q ''<esc>i
"inoremap $e ""<esc>i
"inoremap $t <><esc>i


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General abbreviations
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
iab xdate <c-r>=strftime("%d/%m/%y %H:%M:%S")<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Omni complete functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd FileType css set omnifunc=csscomplete#CompleteCSS

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => From Damian Conway's "more instantly better vim" talk
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"====[ Make the 81st column stand out ]====================

"   " EITHER the entire 81st column, full-screen...
"   highlight ColorColumn ctermbg=magenta
"   set colorcolumn=81

    " OR ELSE just the 81st column of wide lines...
    highlight ColorColumn ctermbg=magenta
    call matchadd('ColorColumn', '\%81v', 100)

"   " OR ELSE on April Fools day...
"   highlight ColorColumn ctermbg=red ctermfg=blue
"   exec 'set colorcolumn=' . join(range(2,80,3), ',')


"=====[ Highlight matches when jumping to next ]=============

"   " This rewires n and N to do the highlighing...
"   nnoremap <silent> n   n:call HLNext(0.3)<cr>
"   nnoremap <silent> N   N:call HLNext(0.3)<cr>


"   " EITHER blink the line containing the match...
"   function! HLNext (blinktime)
"       set invcursorline
"       redraw
"       exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
"       set invcursorline
"       redraw
"   endfunction

"   " OR ELSE ring the match in red...
"   function! HLNext (blinktime)
"       highlight RedOnRed ctermfg=red ctermbg=red
"       let [bufnum, lnum, col, off] = getpos('.')
"       let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
"       echo matchlen
"       let ring_pat = (lnum > 1 ? '\%'.(lnum-1).'l\%>'.max([col-4,1]) .'v\%<'.(col+matchlen+3).'v.\|' : '')
"               \ . '\%'.lnum.'l\%>'.max([col-4,1]) .'v\%<'.col.'v.'
"               \ . '\|'
"               \ . '\%'.lnum.'l\%>'.max([col+matchlen-1,1]) .'v\%<'.(col+matchlen+3).'v.'
"               \ . '\|'
"               \ . '\%'.(lnum+1).'l\%>'.max([col-4,1]) .'v\%<'.(col+matchlen+3).'v.'
"       let ring = matchadd('RedOnRed', ring_pat, 101)
"       redraw
"       exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
"       call matchdelete(ring)
"       redraw
"   endfunction

"   " OR ELSE briefly hide everything except the match...
"   function! HLNext (blinktime)
"       highlight BlackOnBlack ctermfg=black ctermbg=black
"       let [bufnum, lnum, col, off] = getpos('.')
"       let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
"       let hide_pat = '\%<'.lnum.'l.'
"               \ . '\|'
"               \ . '\%'.lnum.'l\%<'.col.'v.'
"               \ . '\|'
"               \ . '\%'.lnum.'l\%>'.(col+matchlen-1).'v.'
"               \ . '\|'
"               \ . '\%>'.lnum.'l.'
"       let ring = matchadd('BlackOnBlack', hide_pat, 101)
"       redraw
"       exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
"       call matchdelete(ring)
"       redraw
"   endfunction

"   " OR ELSE just highlight the match in red...
"   function! HLNext (blinktime)
"       let [bufnum, lnum, col, off] = getpos('.')
"       let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
"       let target_pat = '\c\%#\%('.@/.'\)'
"       let ring = matchadd('WhiteOnRed', target_pat, 101)
"       redraw
"       exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
"       call matchdelete(ring)
"       redraw
"   endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
func! DeleteTillSlash()
    let g:cmd = getcmdline()

    if has("win16") || has("win32")
        let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\]\\).*", "\\1", "")
    else
        let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*", "\\1", "")
    endif

    if g:cmd == g:cmd_edited
        if has("win16") || has("win32")
            let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\\]\\).*\[\\\\\]", "\\1", "")
        else
            let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*/", "\\1", "")
        endif
    endif

    return g:cmd_edited
endfunc

func! CurrentFileDir(cmd)
    return a:cmd . " " . expand("%:p:h") . "/"
endfunc

func! BeginProfilingVim()
    profile start /tmp/vim-profile.log
    profile func *
    profile file *
endfunc

func! FinishProfilingVim()
    profile pause
    noautocmd qall!
endfunc

