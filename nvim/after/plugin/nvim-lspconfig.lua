local lsp = require'lsp-zero'

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({ buffer = bufnr })
end)

-- always show icon column
vim.o.signcolumn = 'yes'

-- lsp.preset('recommended')

lsp.ensure_installed({
  'tsserver',
  'lua_ls',
  'emmet_ls',
})

lsp.configure('omnisharp', {
  settings = {
    omnisharp = {
      useModernNet = false,
      monoPath = '/Library/Frameworks/Mono.framework/Versions/Current/',
    }
  }
})

lsp.configure('lua_ls', {
  settings = {
    Lua = {
      diagnostics = {
        globals = {
          'vim', 'jit', 'color'
        }
      }
    }
  }
})

vim.diagnostic.config({
  virtual_text = false, -- show text after diagnostics
  signs = true,
  update_in_insert = false,
  underline = true,
  severity_sort = false,
  float = true,
})

lsp.configure('tsserver', {
  -- filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'html', 'svelte' }
})

lsp.configure('emmet_ls', {
  filetypes = { 'html', 'markdown', 'javascriptreact', 'typescriptreact', 'vue', 'astro', 'css', 'sass', 'scss', 'less', 'svelte' },
  init_options = {
    html = {
      options = {
        ['jsx.enabled'] = true
      }
    }
  }
})

lsp.configure('volar', {})

-- Show diagnostics text on cursor hold
local lspGroup = vim.api.nvim_create_augroup('Lsp', { clear = true })

vim.api.nvim_create_autocmd('CursorHold', {
  command = 'lua vim.diagnostic.open_float()',
  group = lspGroup
})

lsp.set_sign_icons({
  error = '',
  warn = '',
  hint = '',
  info = ''
})

-- (Optional) Configure lua language server for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

lsp.setup()
