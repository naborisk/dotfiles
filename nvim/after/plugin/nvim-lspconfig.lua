local mason_lspconfig = require 'mason-lspconfig'

-- ensure certain servers are installed
mason_lspconfig.setup {
  ensure_installed = {
    -- 'tsserver',
    -- 'lua_ls',
    -- 'emmet_ls',
  },
}

-- always show icon column
vim.o.signcolumn = 'yes'

-- Adding custom language server
vim.lsp.config('omnisharp_mono', {
  cmd = { 'omnisharp-mono', '--languageserver', '--hostPID', tostring(vim.fn.getpid()) },
  filetypes = { 'cs' },
  root_markers = { '*.csproj', '*.sln', '.git' },
  settings = {
    omnisharp = {
      useModernNet = false,
      -- monoPath = '/Library/Frameworks/Mono.framework/Versions/Current/',
      --
      -- supports multi platform
      monoPath = vim.fn.system { 'which', 'mono' },
    },
  },
})

-- Per-server configurations
vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      diagnostics = {
        globals = {
          'vim',
          'jit',
          'Snacks',
        },
      },
    },
  },
})

vim.lsp.config('ansiblels', {
  -- filetypes = { 'yaml' },
  settings = {
    ansible = {
      validation = {
        lint = {
          enabled = false,
        },
      },
    },
  },
})

-- tsserver: filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'html', 'svelte' }

vim.lsp.config('tailwindcss', {
  filetypes = {
    'html',
    'svelte',
    'astro',
    'vue',
    'javascriptreact',
    'typescriptreact',
  },
})

vim.lsp.config('emmet_ls', {
  filetypes = {
    'html',
    'markdown',
    'javascriptreact',
    'typescriptreact',
    'vue',
    'astro',
    'css',
    'sass',
    'scss',
    'less',
    'svelte',
  },

  init_options = {
    html = {
      options = {
        ['jsx.enabled'] = true,
      },
    },
  },
})

vim.lsp.config('volar', {
  filetypes = { 'javascript', 'typescript', 'vue' },
})

-- Global defaults: capabilities for all servers
vim.lsp.config('*', {
  capabilities = vim.lsp.protocol.make_client_capabilities(),
})

-- note: omnisharp and omnisharp_mono shouldn't be installed together
local servers = mason_lspconfig.get_installed_servers()
servers = vim.tbl_map(function(s)
  -- hotfix for tsserver until it's fixed in mason
  return s == 'tsserver' and 'ts_ls' or s
end, servers)
vim.lsp.enable(servers)

vim.diagnostic.config {
  virtual_text = false, -- show text after diagnostics
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '',
      [vim.diagnostic.severity.WARN] = '',
      [vim.diagnostic.severity.HINT] = '',
      [vim.diagnostic.severity.INFO] = '',
    },
  },
  update_in_insert = false,
  underline = true,
  severity_sort = false,
  float = true,
}

-- Show diagnostics text on cursor hold
local lspGroup = vim.api.nvim_create_augroup('Lsp', { clear = true })

vim.api.nvim_create_autocmd('CursorHold', {
  callback = function()
    vim.diagnostic.open_float()
  end,
  group = lspGroup,
})
