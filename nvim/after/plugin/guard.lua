local ft = require 'guard.filetype'

ft('lua'):fmt 'stylua'
ft('javascript,typescript,javascriptreact,typescriptreact'):fmt 'prettier'

require('guard').setup {
  fmt_on_save = true,
  lsp_as_default_formatter = true,
}
