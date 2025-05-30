local conditions = require 'heirline.conditions'

local LSPActive = {
  condition = conditions.lsp_attached,
  update = { 'LspAttach', 'LspDetach' },
  provider = function()
    return ' ' .. #vim.lsp.get_clients { bufnr = 0 } .. ' '
  end,
  hl = { bg = 'blue', bold = true },
}

return LSPActive
