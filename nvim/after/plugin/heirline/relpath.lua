local RelPath = {
  provider = function()
    return vim.fn.expand '%:.'
  end,
  hl = {
    fg = 'bright_fg',
  },
}

return RelPath
