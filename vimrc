" explicitly set encoding to fix powerline glyphs in GVim
set encoding=utf-8

" configure tmuxline
let g:airline#extensions#tmuxline#enabled = 0
let g:tmuxline_theme = 'powerline'
let g:tmuxline_status_justify = 'left'
let g:tmuxline_preset = {
    \'a': '#S',
    \'win': ['#I', '#W'],
    \'cwin': ['#I', '#W'],
    \'y': '#(whoami)',
    \'z': '#H'}

" manually load pathogen so we can source it from git
runtime bundle/vim-pathogen/autoload/pathogen.vim

" load pathogen bundles
call pathogen#infect()

" load vim-plug
call plug#begin('~/.vim-plugged')
Plug 'edkolev/tmuxline.vim'
Plug 'sheerun/vim-polyglot'
call plug#end()

" general options
set nocompatible
set background=dark
set guifont=Hack:h10:cANSI:qDRAFT,Fira\ Code:h10,Consolas:h11
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

" tweak terminal configuration (these settings corrupt Windows consoles)
if !has("gui_running") && !has("win32")
    " explicitly enable terminal true colors (helps with tmux)
    let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"

    " let console vim change the cursor shape?
    let &t_SI = "\<Esc>[6 q"
    let &t_SR = "\<Esc>[4 q"
    let &t_EI = "\<Esc>[2 q"
end

" use gui colors in the terminal
set termguicolors

" set color scheme
colorscheme gruvbox

" options for the airline plugin
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" prevent netrw from saving history?
let g:netrw_dirhistmax=0

" set the default size for gui windows
if &diff && has("win32")
    autocmd GUIEnter * simalt ~x
else
    autocmd GUIEnter * set lines=50 columns=120
end

" use system temp for swap
if has("win32")
    set directory=$TEMP
else
    set directory=/tmp
end

