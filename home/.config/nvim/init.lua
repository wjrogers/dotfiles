-- set leader
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- hmm
vim.g.have_nerd_font = false

-- early
require('options')

-- plugins!
vim.pack.add({
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/nvim-mini/mini.nvim",
})

-- mini: custom autogroup
local gr = vim.api.nvim_create_augroup('custom-config', {})
_G.Config = {}
_G.Config.new_autocmd = function(event, pattern, callback, desc)
  local opts = { group = gr, pattern = pattern, callback = callback, desc = desc }
  vim.api.nvim_create_autocmd(event, opts)
end

-- mini
require('mini.deps').setup()
local now, later = MiniDeps.now, MiniDeps.later

-- mini: basics
now(function() vim.cmd('colorscheme miniwinter') end)
now(function() require('mini.notify').setup() end)
now(function() require('mini.statusline').setup() end)
now(function() require('mini.tabline').setup() end)

-- mini: later
later(function() require('mini.bracketed').setup() end)
later(function() require('mini.extra').setup() end)
later(function() require('mini.pick').setup() end)

-- late
require('keymaps')
require('completion')
