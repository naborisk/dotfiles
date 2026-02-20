local bit = require 'bit'

local function mode_to_string(mode)
  local flags = { 'r', 'w', 'x' }
  local parts = {}
  -- owner, group, other (bits 8..0)
  for i = 2, 0, -1 do
    for j = 2, 0, -1 do
      local mask = bit.lshift(1, i * 3 + j)
      parts[#parts + 1] = bit.band(mode, mask) ~= 0 and flags[3 - j] or '-'
    end
  end
  return table.concat(parts)
end

local Perms = {
  condition = function()
    return vim.api.nvim_buf_get_name(0) ~= ''
  end,

  update = { 'BufEnter', 'BufWritePost' },

  init = function(self)
    local stat = vim.uv.fs_stat(vim.api.nvim_buf_get_name(0))
    self.perms = stat and mode_to_string(stat.mode) or nil
  end,

  provider = function(self)
    return self.perms
  end,
}

return Perms
