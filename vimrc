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
set formatoptions-=ro
set showmatch
set splitright

" highlight searches, and be case sensitive only when asked
set hlsearch
set incsearch
set ignorecase
set smartcase

" allow modelines in files
set modeline
set modelines=3

" don't show the mode; we have a statusline for that
set noshowmode

" explicitly enable terminal true colors (helps with tmux)
let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors

" set color scheme
if filereadable(expand("~/.vimrc_background"))
    let base16colorspace=256
    source ~/.vimrc_background
else
    colorscheme palenight
endif

" options for the airline plugin
let g:airline#extensions#tabline#enabled = 1
let g:airline_left_sep = ''
let g:airline_right_sep = ''

" prevent netrw from saving history?
let g:netrw_dirhistmax=0

" let console vim change the cursor shape?
if !has("gui_running")
    let &t_SI = "\<Esc>[6 q"
    let &t_SR = "\<Esc>[4 q"
    let &t_EI = "\<Esc>[2 q"
end

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

