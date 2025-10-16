local nmap_leader = function(suffix, rhs, desc)
  vim.keymap.set('n', '<Leader>'..suffix, rhs, { desc = desc })
end
local xmap_leader = function(suffix, rhs, desc)
  vim.keymap.set('x', '<Leader>'..suffix, rhs, { desc = desc })
end

-- leader: f is for find
nmap_leader('fb', '<Cmd>Pick buffers<CR>', 'Buffers')
nmap_leader('fd', '<Cmd>Pick diagnostics scope="current"<CR>', 'Diagnostics (buffer)')
nmap_leader('fD', '<Cmd>Pick diagnostics scope="all"<CR>', 'Diagnostics (workspace)')
nmap_leader('ff', '<Cmd>Pick files<CR>', 'Files')
nmap_leader('fg', '<Cmd>Pick grep_live<CR>', 'Grep live')
nmap_leader('fo', '<Cmd>Pick oldfiles<CR>', 'Recent Files')
nmap_leader('fr', '<Cmd>Pick lsp scope="references"<CR>', 'References')
nmap_leader('fs', '<Cmd>Pick lsp scope="document_symbol"<CR>', 'Symbols (buffer)')
nmap_leader('fS', '<Cmd>Pick lsp scope="workspace_symbol"<CR>', 'Symbols (workspace)')
nmap_leader('fz', '<Cmd>Pick resume<CR>', 'Resume')

