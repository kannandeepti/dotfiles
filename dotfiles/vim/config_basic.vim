
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=10000

" relative line numbers for awesome movement
set relativenumber

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
nnoremap <Space> <Nop>
let mapleader = "\<Space>"
let g:mapleader = "\<Space>"
let maplocalleader = "\<Space>"
let g:maplocalleader = "\<Space>"

" Fast saving
nmap <leader>w :w!<cr>
vmap <leader>w :w!<cr>

" :W sudo saves the file
" (useful for handling the permission-denied error)
if has("win16") || has("win32")
    command! W w
else
    command! W w !sudo tee % > /dev/null
endif

nmap <leader>W :W<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" for non-gvim goodness
set mouse=a

" Set 3 lines to the cursor - when moving vertically using j/k
set so=3

" Turn on the WiLd menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
" Ignore repositories
if has("win16") || has("win32")
    set wildignore+=*.git\*,*.hg\*,*.svn\*,*\.DS_Store
else
    set wildignore+=*.git/*,*.hg/*,*.svn/*,*/.DS_Store
endif

" have the wildmenu emulate terminal tab completion
set wildmode=list:longest

" complete from current file, loaded then unloaded buffers, tags, included
" files, and the dictionary but only if spell is on
set complete=.,w,b,t,i,kspell

" keep my own dictionaries
set dictionary-=/usr/share/dict/words dictionary+=~/.vim/words/english.txt
" including filetype specific dictionaries
au FileType * execute 'setlocal dict+=~/.vim/words/'.&filetype.'.txt'

"Always show current position
set ruler

" Height of the command bar, at least two required for various other
" parts of the config
set cmdheight=2

" A buffer becomes hidden when it is abandoned
set hidden

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
"set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
"set novisualbell
set t_vb=
set tm=500

" Add a bit extra margin to the left
set foldcolumn=1

" Clever startup hook
" if no file specified, open nerdtree
" But I no longer use NERDTree, so this is now an artifact
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" don't time out on command input
set notimeout
set nottimeout


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable

" prettier colors, even in terminal
set t_Co=256

set background=dark

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

" Set utf8 as standard encoding and en_US as the standard language
"set encoding=utf8

" Use Unix as the standard file type
"set ffs=unix,dos,mac

set showcmd
set title

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4
set softtabstop=4
set shiftround
set autoindent

set linebreak
set textwidth=80

set nosmartindent
set wrap "Wrap lines


""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f', '')<CR>
vnoremap <silent> # :call VisualSelection('b', '')<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" readline-style shortcuts
inoremap <silent> <C-e> <Esc>$a
inoremap <silent> <C-a> <Esc>0i

" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

" readline-style motion in command/insert modes
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
cnoremap <C-K> <C-U>
cnoremap <C-N> <Down>
cnoremap <C-P> <Up>
cnoremap <C-D> <Right><Backspace>
cnoremap <C-F> <Right>
cnoremap <C-B> <Left>
inoremap <C-D> <Right><Backspace>
inoremap <C-F> <Right>
inoremap <C-B> <Left>

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Alt way to move between windows
"map <C-j> <C-W>j
"map <C-k> <C-W>k
"map <C-h> <C-W>h
"map <C-l> <C-W>l

" shortcuts to move between and jump to buffers by number
map <leader>b0 :0b<cr>
map <leader>b1 :1b<cr>
map <leader>b2 :2b<cr>
map <leader>b3 :3b<cr>
map <leader>b4 :4b<cr>
map <leader>b5 :5b<cr>
map <leader>b6 :6b<cr>
map <leader>b7 :7b<cr>
map <leader>b8 :8b<cr>
map <leader>b9 :9b<cr>
map <leader>bn :bn<cr>
map <leader>bp :bp<cr>
" Close the current buffer
map <leader>bd :Bclose<cr>
" Close all the buffers
map <leader>ba :1,1000 bd!<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>td :tabclose<cr>
map <leader>tm :tabmove<cr>
map <leader>t<leader> :tabnext<cr>

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Remember info about open buffers on close
set viminfo^=%


""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Format the status line
" current set by airline instead
" set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap VIM 0 to first non-blank character
"map 0 ^

" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
" autocmd BufWrite *.py :call DeleteTrailingWS()
" autocmd BufWrite *.coffee :call DeleteTrailingWS()
" a nice shortcut for it
map <leader>dtw :call DeleteTrailingWS()<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set foldenable
set foldlevelstart=10
set foldnestmax=10

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing <leader>ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Toggle paste mode on and off
map <leader>P :setlocal paste!<cr>

" so tired of accidentally ending up in record mode
nnoremap q: :q
" and of accidentally putting capital letters for commands...
command! Q q

" catchall cleanup
nnoremap <leader><cr> <C-c>:call DeleteTrailingWS()<cr>:noh<cr>:redraw!<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => netrw config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:netrw_list_hide='^.*\.o$,^.*\~$,^.*\.pyc$,^\.hg.*$,^\.svn.*$,^\.git/.*$,^.*/\.hg/.*$,^.*/\.svn/.*$,^\.\.\=/\=$'
let g:netrw_sort_options="i"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("Ack \"" . l:pattern . "\" " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction


" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction

