-- set leader
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- hmm
vim.g.have_nerd_font = false

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
vim.o.formatoptions = 'rqnl1j'
vim.o.shiftwidth = 2
vim.o.smartindent = true
vim.o.tabstop = 2

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

-- options: gui
vim.o.guifont = 'Consolas:h12'

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

-- mini: completion
later(function()
  -- don't show 'Text' suggestions (usually noisy) and show snippets last
  local process_items_opts = { kind_priority = { Text = -1, Snippet = 99 } }
  local process_items = function(items, base)
    return MiniCompletion.default_process_items(items, base, process_items_opts)
  end
  require('mini.completion').setup({
    lsp_completion = {
      source_func = 'omnifunc',
      auto_setup = false,
      process_items = process_items,
    },
  })

  -- set 'omnifunc' for LSP completion
  local on_attach = function (ev)
    vim.bo[ev.buf].omnifunc = 'v:lua.MiniCompletion.completefunc_lsp'
  end
  _G.Config.new_autocmd('LspAttach', nil, on_attach, "Set 'omnifunc'")

  -- advertise mini.completion capabilities to LSP servers
  vim.lsp.config('*', { capabilities = MiniCompletion.get_lsp_capabilities() })
end)

-- lsp
vim.lsp.enable("lua_ls")
