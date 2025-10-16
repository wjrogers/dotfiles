-- many filetype plugins set these options; make them go away!
local disable_formatoptions = function()
  vim.cmd("setlocal formatoptions-=o formatoptions-=r")
end
_G.Config.new_autocmd("FileType", nil, disable_formatoptions, "disable unwanted formatoptions")
