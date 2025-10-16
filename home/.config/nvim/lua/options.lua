-- options: general UI
vim.o.breakindent = true
vim.o.confirm = true
vim.o.mouse = 'a'
vim.o.number = true
vim.o.showmode = false
vim.o.signcolumn = 'yes'
vim.o.undofile = true

-- options: indents
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.smartindent = true
vim.o.tabstop = 2
vim.opt.formatoptions:append('ln1')

-- options: splits
vim.o.splitbelow = true
vim.o.splitright = true

-- options: searching
vim.o.ignorecase = true
vim.o.inccommand = 'split'
vim.o.smartcase = true

-- options: cursor behavior
vim.o.cursorline = true
vim.o.scrolloff = 10

-- options: completion
vim.o.complete = '.,w,b,kspell'
vim.o.completeopt = 'menuone,noselect,fuzzy,nosort'
vim.o.pumblend = 10
vim.o.pumheight = 10
vim.o.winblend = 10

-- options: gui
vim.o.guifont = 'Consolas:h12'

