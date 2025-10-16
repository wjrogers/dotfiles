--@type vim.lsp.Config
return {
  on_attach = function(client, buf_id)
    -- reduce very long list of triggers for better 'mini.completion' experience
    client.server_capabilities.completionProvider.triggerCharacters = { '.', ':', '#', '(' }
  end,
  -- structure of these settings comes from LuaLS, not Neovim
  settings = {
    Lua = {
      -- use 'LuaJIT' because it's built into Neovim
      runtime = { version = 'LuaJIT', path = vim.split(package.path, ';') },
      workspace = {
        ignoreSubmodules = true,
        -- add Neovim's API
        library = { vim.env.VIMRUNTIME },
      },
    },
  },
}

