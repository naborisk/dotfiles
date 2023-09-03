local FullPath = {
  provider = function()
    return vim.api.nvim_buf_get_name(0)
  end,
}

return FullPath
