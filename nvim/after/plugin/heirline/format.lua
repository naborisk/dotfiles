local FormatStatus = {
  -- Only show when formatting is disabled
  condition = function()
    return vim.g.disable_autoformat or vim.b.disable_autoformat
  end,
  update = { 'User', pattern = 'FormatStatusChanged', callback = vim.schedule_wrap(function() vim.cmd 'redrawstatus' end) },
  provider = function()
    if vim.b.disable_autoformat then
      return ' nofmt(buf) '
    end
    return ' nofmt '
  end,
  hl = function()
    if vim.b.disable_autoformat then
      return { fg = 'orange', bold = true }
    end
    return { fg = 'red', bold = true }
  end,
}

return FormatStatus
