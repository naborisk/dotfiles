local lspconfig = require 'lspconfig'
local mason_lspconfig = require 'mason-lspconfig'

local configs = require 'lspconfig.configs'

-- Get installed language servers from mason
local get_servers = mason_lspconfig.get_installed_servers

local navic = require 'nvim-navic'

-- Get cmp_nvim_lsp capabilities
local cmp_nvim_lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Get lsp-file-operations capabilities
local lsp_file_op_capabilities = require('lsp-file-operations').default_capabilities()

-- ensure certain servers are installed
mason_lspconfig.setup {
  ensure_installed = {
    -- 'tsserver',
    -- 'lua_ls',
    -- 'emmet_ls',
  },
}

-- Adding custom language server
if not configs.omnisharp_mono then
  configs.omnisharp_mono = {
    default_config = {
      cmd = { 'omnisharp-mono', '--languageserver', '--hostPID', tostring(vim.fn.getpid()) },
      filetypes = { 'cs' },
      root_dir = lspconfig.util.root_pattern('*.csproj', '*.sln', '.git'),
      settings = {},
    },
  }
end

-- always show icon column
vim.o.signcolumn = 'yes'

-- lsp configurations
local lsp_options = {
  omnisharp_mono = {
    settings = {
      omnisharp = {
        useModernNet = false,
        -- monoPath = '/Library/Frameworks/Mono.framework/Versions/Current/',
        --
        -- supports multi platform
        monoPath = vim.fn.system { 'which', 'mono' },
      },
    },
  },

  lua_ls = {
    settings = {
      Lua = {
        diagnostics = {
          globals = {
            'vim',
            'jit',
            'color',
          },
        },
      },
    },
  },

  ansiblels = {
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
  },

  tsserver = {
    -- filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'html', 'svelte' }
  },

  tailwindcss = {
    filetypes = {
      'html',
      'svelte',
      'astro',
      'vue',
      'javascriptreact',
      'typescriptreact',
    },
  },

  emmet_ls = {
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
  },

  volar = {
    filetypes = { 'javascript', 'typescript', 'vue' },
  },
}

-- note: omnisharp and omnisharp_mono shouldn't be insalled together
lspconfig.util.default_config = vim.tbl_extend('force', lspconfig.util.default_config, {
  capabilities = vim.tbl_deep_extend(
    'force',
    vim.lsp.protocol.make_client_capabilities(),
    cmp_nvim_lsp_capabilities,
    lsp_file_op_capabilities
  ),
})

-- run setup() for every installed servers by mason, apply config if defined in lsp_options table
for _, server_name in ipairs(get_servers()) do
  -- get configurations from lsp_options table
  local settings = lsp_options[server_name] and lsp_options[server_name].settings or {}
  local filetypes = lsp_options[server_name] and lsp_options[server_name].filetypes or nil

  -- hotfix for tsserver until it's fixed in mason
  server_name = server_name == 'tsserver' and 'ts_ls' or server_name

  lspconfig[server_name].setup {
    filetypes = filetypes,
    settings = settings,
    -- capabilities = ,
    on_attach = function(client, bufnr)
      if client.server_capabilities.documentSymbolProvider then
        navic.attach(client, bufnr)
      end
    end,
  }
end

vim.diagnostic.config {
  virtual_text = false, -- show text after diagnostics
  signs = true,
  update_in_insert = false,
  underline = true,
  severity_sort = false,
  float = true,
}

-- Show diagnostics text on cursor hold
local lspGroup = vim.api.nvim_create_augroup('Lsp', { clear = true })

vim.api.nvim_create_autocmd('CursorHold', {
  command = 'lua vim.diagnostic.open_float()',
  group = lspGroup,
})

-- Change diagnostic signs
local signs = {
  Error = '',
  Warn = '',
  Hint = '',
  Info = '',
}

for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
