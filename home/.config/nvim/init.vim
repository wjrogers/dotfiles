" share runtime files with vim
set runtimepath^=~/.vim runtimepath+=~/.vim/after

" configure gutentags
let g:gutentags_cache_dir = expand('~/.cache/tags')

" load vim-plug
call plug#begin('~/.vim-plugged')

" deliberately ordered
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/lsp-status.nvim'
Plug 'hrsh7th/nvim-cmp'

" alphabetical
Plug 'arcticicestudio/nord-vim'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'ludovicchabant/vim-gutentags'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-telescope/telescope.nvim'
Plug 'samoshkin/vim-mergetool'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" languages
Plug 'hashivim/vim-terraform'
call plug#end()

" behavior preferences
set formatoptions-=ro
set hidden
set showmatch
set splitright

" language options
set completeopt=menuone,noinsert
set inccommand=nosplit
set shortmess+=c
set signcolumn=yes
set updatetime=300

" highlight searches, and be case sensitive only when asked
set hlsearch
set incsearch
set ignorecase
set smartcase

" colorscheme
set termguicolors
colorscheme nord

" options for airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" options for vim-mergetool
let g:mergetool_layout = 'LmR'
let g:mergetool_prefer_revision = 'local'

" prevent netrw from saving history?
let g:netrw_dirhistmax=0

" set leader to space
noremap <silent> <Space> <Nop>
let mapleader = " "
let maplocalleader = " "

" telescope bindings
nnoremap <silent> <C-p> <cmd>Telescope find_files<cr>
nnoremap <silent> <leader><leader> <cmd>Telescope buffers<cr>
nnoremap <silent> <leader>f <cmd>Telescope current_buffer_fuzzy_find<cr>
nnoremap <silent> <leader>o <cmd>Telescope oldfiles<cr>
nnoremap <silent> <leader>r <cmd>Telescope registers<cr>
nnoremap <silent> <leader>t <cmd>Telescope tags<cr>

" lsp servers
lua require'lspconfig'.terraformls.setup{}

