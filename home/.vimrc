" explicitly set encoding to fix powerline glyphs in GVim
set encoding=utf-8

" set leader to space
let mapleader = ' '

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

" configure ale
let g:ale_completion_enabled = 1
set omnifunc=ale#completion#OmniFunc

" configure gutentags
let g:gutentags_cache_dir = expand('~/.cache/tags')

" load vim-plug
call plug#begin('~/.vim-plugged')
Plug 'arcticicestudio/nord-vim'
Plug 'dense-analysis/ale'
Plug 'edkolev/tmuxline.vim'
Plug 'junegunn/fzf' " obtains only fzf.vim, must install binaries elsewhere
Plug 'junegunn/fzf.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'morhetz/gruvbox'
Plug 'samoshkin/vim-mergetool'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end()

" general options
set nocompatible
set background=dark
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

" better linting experience
set updatetime=300

" don't show useless completion messages
set shortmess+=c

" gui options
set guioptions-=mrLtT
set guioptions+=!
if !has("nvim")
  set guifont=Hack:h10,Fira\ Code:h10,Consolas:h11
end

" tweak terminal configuration (these settings corrupt Windows consoles)
if !has("gui_running") && !has("win32")
    let &t_SI = "\<Esc>[6 q"
    let &t_SR = "\<Esc>[4 q"
    let &t_EI = "\<Esc>[2 q"
end

" use gui colors in the terminal
let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors

" set color scheme
colorscheme nord

" options for the airline plugin
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" options for the mergetool plugin
let g:mergetool_layout = 'LmR'
let g:mergetool_prefer_revision = 'local'

" prevent netrw from saving history?
let g:netrw_dirhistmax=0

" customize fzf options
let $FZF_DEFAULT_OPTS = '--ansi --reverse'

" customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" fzf mappings
nmap <C-p> :Files<CR>
nmap <Leader>b :Buffers<CR>
nmap <Leader>f :Files<CR>
nmap <Leader>h :Commits<CR>
nmap <Leader>i :Lines<CR>
nmap <Leader>r :History<CR>
nmap <Leader>t :Tags<CR>

" fzf mappings - visual mode
vnoremap <Leader>g y:Rg <C-r>"<CR>
vnoremap <Leader>G y:Rg <C-r>"

" set the default size for gui windows
if &diff && has("win32")
    autocmd GUIEnter * simalt ~x
else
    autocmd GUIEnter * set lines=50 columns=120
end

" balance splits when resizing in diff mode
function ResizeDiffSplits()
  if &diff
    execute "normal \<C-w>="
  end
endfunction
augroup resize-diff
  au!
  au VimResized,WinNew * call ResizeDiffSplits()
augroup end

" use system temp for swap
if has("win32")
    set directory=$TEMP
else
    set directory=/tmp
end

