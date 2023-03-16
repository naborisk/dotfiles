local lsp = require('lsp-zero')

-- always show icon column
vim.o.signcolumn = 'yes'

lsp.preset('recommended')

lsp.ensure_installed({
  'tsserver',
  'lua_ls',
  'emmet_ls'
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

vim.diagnostic.config({
  -- virtual_text = true,
  signs = true,
  update_in_insert = false,
  underline = true,
  severity_sort = false,
  float = true,
})

lsp.configure('emmet_ls', {
  filetypes = {'html', 'markdown', 'javascript', 'astro', 'typescriptreact'}
})

-- local pid = vim.fn.getpid()
-- local omnisharp_bin = "/Users/naborisk/.local/share/nvim/mason/packages/omnisharp-mono/run"
-- local omnisharp_binn = "/.local/share/nvim/mason/packages/omnisharp-mono/run"
--
-- lsp.configure('omnisharp_mono', {
--   cmd = {omnisharp_bin, "--languageserver", "--hostPID", pid}
-- })

-- require'lspconfig'.omnisharp.setup {
--  cmd = {omnisharp_bin, "--languageserver", "--hostPID", pid}
-- }

lsp.set_preferences({
  sign_icons = {
    error = '',
    warn = '',
    hint = '',
    info = ''
  }
})

lsp.setup()
