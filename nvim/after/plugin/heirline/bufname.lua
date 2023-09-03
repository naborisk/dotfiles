local Bufname = {
  provider = function()
    return vim.fn.expand '%'
  end,
}

return Bufname
