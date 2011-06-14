" general options
set nocompatible
set incsearch
set hlsearch
set showmatch
set ignorecase
set backspace=indent,eol,start
set sw=4
set ts=4
set expandtab
set autoindent
set guioptions=rL
set wildmenu
set hidden
set encoding=utf-8
set splitright
set nobackup

" allow modelines in files
set modeline
set modelines=3

" turn on syntax highlighting and plugin stuff
syntax on
filetype plugin indent on

" set color scheme
colorscheme mustang

" options for the enhanced python syntax file
let python_highlight_all = 1
let python_slow_sync = 1

" options for the supertab tab-completion plugin
let g:SuperTabDefaultCompletionType = "context"

" prevent netrw from saving history?
let g:netrw_dirhistmax=0

" set up the status bar the way I like
set laststatus=2
set statusline=
set statusline+=%-3.3n\                         " buffer number
set statusline+=%f\                             " file name
set statusline+=%h%m%r%w                        " flags
set statusline+=\[%{strlen(&ft)?&ft:'none'},    " filetype
set statusline+=%{&encoding},                   " encoding
set statusline+=%{&fileformat}]                 " file format
set statusline+=%{fugitive#statusline()}        " git status
set statusline+=%=                              " right align
set statusline+=0x%-8B\                         " current char
set statusline+=%-14.(%l,%c%V%)\ %<%P           " offset

" set the default size for gui windows
if &diff && has("win32")
    autocmd GUIEnter * simalt ~x
else
    autocmd GUIEnter * set lines=50 columns=120
end

" choose a nicer looking font in Windows
if has("win32")
    set directory=$TEMP
    set guifont=Consolas:h11
else
    set directory=/tmp
end

