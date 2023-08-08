local conditions = require 'heirline.conditions'

local LSPActive = {
  condition = conditions.lsp_attached,
  update    = { 'LspAttach', 'LspDetach' },
  provider  = function()
    return "[" .. #vim.lsp.get_active_clients({ bufnr = 0 }) .. "]"
  end,
  hl        = { bold = true }
}

return LSPActive
