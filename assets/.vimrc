" :echo @% : get current filename

" interface
set term=xterm-256color
set nowrap
set number
set cursorline
highlight LineNr cterm=bold ctermfg=white ctermbg=none
highlight CursorLineNr cterm=bold ctermfg=white ctermbg=DarkGray

set ruler               " show info on right-down corner (default)
set showmode
set encoding=UTF-8
syntax on

" set colorcolumn=81
" execute "set colorcolumn=" . join(range(81,335), ',')
" highlight ColorColumn ctermfg=DarkRed ctermbg=none

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" interaction
set mouse=
set nopaste
set incsearch           " search when typing
set ignorecase          " when search for text
set nohlsearch
set autoindent
set foldmethod=manual
set noundofile          " enable to undo/redo the closed file
                        " disable to prevent .un~ file


" indentation
set tabstop=4
set smartindent
set shiftwidth=4        " spaces when auto-indent
set expandtab           " turn tab into spaces
                        " ^v + <tab> to use original tab
highlight Search ctermfg=none


" popup menu & selected style
set completeopt-=preview        " prevent AutoComplPop split
highlight Pmenu ctermbg=black ctermfg=gray
highlight CocMenuSel ctermbg=darkblue ctermfg=white


" shortcuts
function! ToggleMouse()
    if &mouse == 'a'
        set mouse=
    else
        set mouse=a
    endif
    set mouse?
endfunc

nmap <F2> :set invnumber<CR>
nmap <F3> :set invpaste paste?<CR>
nmap <F4> :set invexpandtab expandtab?<CR>
nmap <F5> :Autoformat<CR>
nmap <F6> :set hlsearch! hlsearch?<CR>
nmap <F7> :call ToggleMouse()<CR>
nmap <F8> :TagbarToggle<CR>

" switching windows/panes/splits: \ + hjkl
    " vim -o|O FILE1 FILE2 : horizontally/vertically
    " :vsplit|split
    " :only
    " <c-w>+ : increase size
    " <c-w>- : decrease size
    " <c-w>= : equalize sizes
nmap <leader>h <C-w>h
nmap <leader>a <C-w>h
nmap <leader>j <C-w>j
nmap <leader>s <C-w>j
nmap <leader>k <C-w>k
nmap <leader>w <C-w>k
nmap <leader>l <C-w>l
nmap <leader>d <C-w>l
set splitbelow
set splitright

" switching tabs: <shift> + left/right
    " vim -p FILE1 FILE2
    " :tabedit FILE
    " :tabm [N] : move to tab N (0-based) (last tab by default)
    " :tabclose [N]
    " :tabonly
map <S-RIGHT> :tabn<cr>
map <S-LEFT> :tabp<cr>

" switching buffered (switchbuf=useopen|usetab|split|newtab)
    " useopen : open new (or switch to) window/pane/split for the buffered file
    " usetab : also consider other tabs
    " :sbnext
    " :sbprevious
set switchbuf=useopen

" text fold (foldmethd=manual|indent|syntax)
    " zf : manually create a fold
    " zo|c|d : open/close/delete a fold
    " zO|M|D : open all / close all / delete recursively
set foldmethod=syntax
set nofoldenable        " open all folds on file opened
nmap <leader>zi :set foldmethod=indent foldmethod?<CR>
nmap <leader>zm :set foldmethod=manual foldmethod?<CR>
nmap <leader>zs :set foldmethod=syntax foldmethod?<CR>
nmap <leader>zz :set invfoldenable<CR>
" autocmd BufWinLeave *.* mkview    " save/load text fold
" autocmd BufWinEnter *.* loadview
autocmd BufWritePre * :%s/\s\+$//e


" autocomplete
inoremap #in<space> #include <><ESC>i
inoremap #in<tab> #include ""<ESC>i
inoremap itn int
nmap <S-TAB> <h
nmap <TAB> >l0


" vim plugins
" curl -fLo /home/babysuse/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    " PlugInstall [name ...]
    " PlugUpdate [name ...] : install / update plugins
    " PlugUpgrade : upgrade vim-plugin itself
    " PlugClean[!]
    " PlugStatus
call plug#begin('~/.vim/plugged')
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'scrooloose/nerdtree' |
        \ Plug 'Xuyuanp/nerdtree-git-plugin'

    " IDE supports
    Plug 'vim-syntastic/syntastic'      " check your syntax before you leave
    Plug 'preservim/nerdcommenter'
    Plug 'Chiel92/vim-autoformat'       " cleanup indentation
    Plug 'preservim/tagbar'             " outline viewer for vim

    Plug 'vivien/vim-linux-coding-style'
call plug#end()

" Plug configuration and usage
" Plug 'vim-airline/vim-airline'
    " :AirlineTheme atomic | base16|lucius | biogoo|deus|tomorrow | xtermlight
let g:airline_theme='lucius'
let g:airline_section_y = ''
let g:airline_section_z = '%v:%3l/%3L(%p%%)'
let g:airline#extensions#tabline#enabled = 0                " display all buffers when there's only one tab
let g:airline#extensions#tabline#formatter = 'unique_tail'  " exclude directories

"    
let g:airline_powerline_fonts = 1
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols = {}
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

" Plug 'scrooloose/nerdtree'
    " ? : help
    " o : open
    " x : close
    " i : open in new split
    " t : open in new tab
    " q : quit
nnoremap <silent> <C-o> :NERDTreeToggle<CR>
nnoremap <silent> <leader>] :NERDTreeRefreshRoot<CR>
let NERDTreeCustomOpenArgs = { 'file': { 'where': 'p', 'keepopen': 1, 'stay': 1 } }
let g:deoplete#enable_at_startup = 1
let g:NERDTreeGitStatusConcealBrackets = 1
let g:NERDTreeGitStatusShowIgnored = 1
let g:NERDTreeGitStatusUntrackedFilesMode = 'all'
let g:NERDTreeGitStatusIndicatorMapCustom = {
    \ 'Clean'     :'✔︎',
    \ 'Staged'    :'✚', 'Modified'  :'✹', 'Untracked' :'✭',
    \ 'Renamed'   :'➜', 'Deleted'   :'✖', 'Ignored'   :'☒',
    \ 'Unknown'   :'?', 'Unmerged'  :'═', 'Dirty'     :'✗',
    \ }

" Plug 'vim-syntastic/syntastic'
let g:syntastic_cpp_compiler = 'g++'
let g:syntastic_cpp_compiler_options = ' -std=c++17'
let g:syntastic_mode_map = {
    \ "mode": "active",
    \ "passive_filetypes": ["c"]
    \ }

" Plug 'preservim/nerdcommenter'
    " <leader>ci: invert comment
    " <leader>cs: sexy comment
let NERDSpaceDelims=1

" Plug 'chiel92/vim-autoformat'
    " <F5> : format
