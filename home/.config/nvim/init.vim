" share runtime files with vim
set runtimepath^=~/.vim runtimepath+=~/.vim/after

" configure gutentags
let g:gutentags_cache_dir = expand('~/.cache/tags')

" load vim-plug
call plug#begin('~/.vim-plugged')

" deliberately ordered
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'

" alphabetical
Plug 'arcticicestudio/nord-vim'
Plug 'hrsh7th/nvim-compe'
Plug 'ludovicchabant/vim-gutentags'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-telescope/telescope.nvim'
Plug 'samoshkin/vim-mergetool'
Plug 'tpope/vim-fugitive'
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

" compe
let g:compe = {}
let g:compe.enabled = v:true
let g:compe.autocomplete = v:true
let g:compe.debug = v:false
let g:compe.min_length = 1
let g:compe.preselect = 'enable'
let g:compe.throttle_time = 80
let g:compe.source_timeout = 200
let g:compe.incomplete_delay = 400
let g:compe.max_abbr_width = 100
let g:compe.max_kind_width = 100
let g:compe.max_menu_width = 100
let g:compe.documentation = v:true

" compe sources
let g:compe.source = {}
let g:compe.source.tags = v:true
let g:compe.source.nvim_lsp = v:true
let g:compe.source.nvim_lua = v:true

" compe mappings
inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')

" compe TAB binding
lua <<EOF
local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end

_G.tab_complete_backward = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  else
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.tab_complete_backward()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.tab_complete_backward()", {expr = true})
EOF
