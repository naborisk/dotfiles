local FileName = {
  provider = function()
    return string.gsub(vim.api.nvim_buf_get_name(0), vim.loop.cwd(), '')
  end
}

return FileName
