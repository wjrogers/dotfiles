" manually load pathogen so we can source it from git
runtime bundle/vim-pathogen/autoload/pathogen.vim

" load pathogen bundles
call pathogen#infect()

" general options
set nocompatible
set background=dark
set guioptions=rL
set nobackup

" behavior preferences
set hidden
set showmatch
set splitright

" be case sensitive only when asked
set ignorecase
set smartcase

" allow modelines in files
set modeline
set modelines=3

" set color scheme
colorscheme solarized

" options for the airline plugin
let g:airline#extensions#tabline#enabled = 1
let g:airline_left_sep = ''
let g:airline_right_sep = ''

" prevent netrw from saving history?
let g:netrw_dirhistmax=0

" set the default size for gui windows
if &diff && has("win32")
    autocmd GUIEnter * simalt ~x
else
    autocmd GUIEnter * set lines=50 columns=120
end

" choose a nicer looking font in Windows; use system temp for swap
if has("win32")
    set directory=$TEMP
    set guifont=DejaVu\ Sans\ Mono:h10,Consolas:h11
else
    set directory=/tmp
end

