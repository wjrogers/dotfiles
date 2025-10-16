local now, later = MiniDeps.now, MiniDeps.later

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

