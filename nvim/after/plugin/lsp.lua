local lsp = require('lsp-zero')

-- always show icon column
vim.o.signcolumn = 'yes'

lsp.preset('recommended')

lsp.ensure_installed({
  'tsserver',
  'lua_ls'
})

lsp.configure('lua_ls', {
  settings = {
    Lua = {
      diagnostics = {
        globals = {
          'vim', 'jit'
        }
      }
    }
  }
})

lsp.set_preferences({
  sign_icons = {
    error = '',
    warn = '',
    hint = '',
    info = ''
  }
})

lsp.setup()
