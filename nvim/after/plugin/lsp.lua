local lsp = require('lsp-zero')

-- always show icon column
vim.o.signcolumn = 'yes'

lsp.preset('recommended')

lsp.ensure_installed({
  'tsserver',
  'sumneko_lua'
})

lsp.configure('sumneko_lua', {
  settings = {
    Lua = {
      diagnostics = {
        globals = {'vim'}
      }
    }
  }
})

lsp.setup()
