-- WIP: not working yet maybe
local Perms = {
  provider = function()
    return vim.fn.system('ls -l ' .. vim.api.nvim_buf_get_name(0) .. " | awk '{print $1}'"):match '^%s*(.-)%s*$'
  end,
}

return Perms
