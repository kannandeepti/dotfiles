" Use Vundle for plugins

" This section must be first, and verbatim/as is
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
" some plugin or another that I use is assuming I'm in .vim
" call vundle#rc('~/.vim/bundle')
call vundle#begin('~/.vim/bundle')

"""""""""""""""
" ALL YOUR PLUGINS ARE BELONG TO ME
"""""""""""""""
" Indispensible plugins. Note that gmarik/vundle must come first!
" None of these set any nonstandard options by default
Bundle 'gmarik/vundle'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-git'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-commentary'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-obsession'
Bundle 'scrooloose/syntastic'
Bundle 'scrooloose/nerdtree'
Plugin 'altercation/vim-colors-solarized'
Plugin 'bling/vim-airline'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'godlygeek/tabular'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'davidhalter/jedi-vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'AndrewRadev/linediff.vim'
Plugin 'NLKNguyen/papercolor-theme'
Plugin 'ervandew/supertab'
Plugin 'ivanov/vim-ipython'
Plugin 'brunobeltran/vim-vmath'
Plugin 'brunobeltran/vim-dragvisuals'

" Required after pulling in all the plugins
call vundle#end()
filetype plugin indent on

""""""""""""""
" Now source non-external program dependent, non plugin dependent configs
"""""""""""""""
source ~/.vim/config_basic.vim
source ~/.vim/config_extended.vim

""""""""""""""""
" Now some plugins that need configuration
""""""""""""""""
" colors
" Plugin 'altercation/vim-colors-solarized'
syntax enable
set background=dark
" let g:solarized_termcolors=256
set t_Co=256
" colorscheme PaperColor
colorscheme solarized
" FUCK TMUX
" colorscheme desert

" airline is special, usually requires patched fonts
" Plugin 'bling/vim-airline'
let g:airline#extensions#tabline#enabled=1
let g:airline_theme="luna"
set laststatus=2
"set encoding=utf-8
"let g:airline_powerline_fonts = 1
"set guifont=Fira\ Mono\ Medium\ for\ Powerline:h9

" Easymotion
" Plugin 'Lokaltog/vim-easymotion'
" remove <leader> to use for search by default
map  <Leader>/ <Plug>(easymotion-sn)
omap <Leader>/ <Plug>(easymotion-tn)
vmap <Leader>/ <Plug>(easymotion-tn)
map  <Leader>n <Plug>(easymotion-next)
map  <Leader>N <Plug>(easymotion-prev)
" avoid repeated hjkl input
map <Leader><Leader>l <Plug>(easymotion-lineforward)
map <Leader><Leader>j <Plug>(easymotion-j)
map <Leader><Leader>k <Plug>(easymotion-k)
map <Leader><Leader>h <Plug>(easymotion-linebackward)
let g:EasyMotion_startofline = 0
" smartcase is nice, so only match case if you include an uppercase letter
let g:EasyMotion_smartcase = 1


" ack, better version of grep
" Plugin 'mileszs/ack.vim'


" tabularize can be used to line up stuff based on regexes
" Plugin 'godlygeek/tabular'
" here's a mapping to automatically alighn on | when typing cucumber tables I'd
" like to extend this to align on & (but not on \&), and not in any "verbatim"
" modes like verbatim or lstlisting.
""  inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a
""  function! s:align()
""  let p = '^\s*|\s.*\s|\s*$'
""  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
""      let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
""      let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
""      Tabularize/|/l1
""      normal! 0
""      call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
""  endif
""  endfunction


" Make a seamless interface with tmux
" REQUIRES: extra config on tmux side
" use custom bindings (same as defaults for now)
" Plugin 'christoomey/vim-tmux-navigator'
let g:tmux_navigator_no_mappings = 1
if has("win16") || has("win32")
    nnoremap <silent> <C-S-h> :TmuxNavigateLeft<cr>
    nnoremap <silent> <C-S-j> :TmuxNavigateDown<cr>
    nnoremap <silent> <C-S-k> :TmuxNavigateUp<cr>
    nnoremap <silent> <C-S-l> :TmuxNavigateRight<cr>
    nnoremap <silent> <C-S-\> :TmuxNavigatePrevious<cr>
elseif has("unix") || has("linux")
    inoremap <silent> h  <Esc>:TmuxNavigateLeft<cr>
    inoremap <silent> j  <Esc>:TmuxNavigateDown<cr>
    inoremap <silent> k  <Esc>:TmuxNavigateUp<cr>
    inoremap <silent> l  <Esc>:TmuxNavigateRight<cr>
    inoremap <silent> \  <Esc>:TmuxNavigatePrevious<cr>
    nnoremap <silent> h  :TmuxNavigateLeft<cr>
    nnoremap <silent> j  :TmuxNavigateDown<cr>
    nnoremap <silent> k  :TmuxNavigateUp<cr>
    nnoremap <silent> l  :TmuxNavigateRight<cr>
    nnoremap <silent> \  :TmuxNavigatePrevious<cr>
    cnoremap <silent> h  <Esc>:TmuxNavigateLeft<cr>
    cnoremap <silent> j  <Esc>:TmuxNavigateDown<cr>
    cnoremap <silent> k  <Esc>:TmuxNavigateUp<cr>
    cnoremap <silent> l  <Esc>:TmuxNavigateRight<cr>
    cnoremap <silent> \  <Esc>:TmuxNavigatePrevious<cr>
endif

" Finally
"""""""""""""
" omnicompletion/"intellisense
"""""""""""""
set tags+=tags;$HOME

" Baller addition to omnicompletion: JEDI-VIM
" Plugin 'davidhalter/jedi-vim'
" i use <c-space> for changing keyboard langauges
let g:jedi#completions_command = "<C-N>"
" change this only if you really want to do everything manually
let g:jedi#auto_initialization = 1
" prevent it from being a bully
let g:jedi#auto_vim_configuration = 0
" i'd like it to only select the first option right away when I explicitly call it
" since that option isn't present I'll disable it except for when I explicitly call it
let g:jedi#popup_on_dot = 0
" prevent dumb warning when I'm using an incompatible vim
let g:jedi#squelch_py_warning = 1
let g:jedi#force_py_version = 3

" YOU COMPLETE ME
" Plugin 'Valloric/YouCompleteMe'
let g:ycm_global_ycm_extra_conf = '~/.vim/ycm_extra_conf.py'

"" YouCompleteMe
let g:ycm_key_list_previous_completion=['<Up>']


" MAD SNIPPETS, YO
" let g:UltiSnipsExpandTrigger="<c-x>"
" let g:UltiSnipsJumpForwardTrigger="<c-a>"
" let g:UltiSnipsJumpBackwardTrigger="<c-s>"
" If you want :UltiSnipsEdit to split your window.
" let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetsDir='~/.vim/UltiSnips'
let g:UltiSnipsSnippetDirectories=['UltiSnips']
"" Ultisnips
let g:UltiSnipsExpandTrigger="<c-j>"

" function! g:UltiSnips_Complete()
"     call UltiSnips#ExpandSnippet()
"     if g:ulti_expand_res == 0
"         if pumvisible()
"             return "\<C-n>"
"         else
"             call UltiSnips#JumpForwards()
"             if g:ulti_jump_forwards_res == 0
"                return "\<TAB>"
"             endif
"         endif
"     endif
"     return ""
" endfunction

" au BufEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"
" let g:UltiSnipsJumpForwardTrigger="<tab>"
" let g:UltiSnipsListSnippets="<c-e>"
" " this mapping Enter key to <C-y> to chose the current highlight item
" " and close the selection list, same as other IDEs.
" " CONFLICT with some plugins like tpope/Endwise
" inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
"

" from Damian Conway
"====[ dragvisuals ]====================
"#########################################################################
"##                                                                     ##
"##  Add the following (uncommented) to your .vimrc...                  ##
"##                                                                     ##
runtime plugin/dragvisuals.vim

vmap  <expr>  <LEFT>   DVB_Drag('left')
vmap  <expr>  <RIGHT>  DVB_Drag('right')
vmap  <expr>  <DOWN>   DVB_Drag('down')
vmap  <expr>  <UP>     DVB_Drag('up')
vmap  <expr>  D        DVB_Duplicate()
" Remove any introduced trailing whitespace after moving...
let g:DVB_TrimWS=1

"====[ vmath ]====================
vmap <expr>  ++  VMATH_YankAndAnalyse()
nmap         ++  vip++
