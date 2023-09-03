local FileName = {
  provider = function()
    return vim.fn.expand '%:t'
  end,
}

return FileName
