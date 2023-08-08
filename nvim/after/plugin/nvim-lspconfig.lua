local lspconfig = require 'lspconfig'
local mason_lspconfig = require 'mason-lspconfig'

local configs = require 'lspconfig.configs'

-- Get installed language servers from mason
local get_servers = mason_lspconfig.get_installed_servers

-- ensure certain servers are installed
mason_lspconfig.setup {
  ensure_installed = {
    'tsserver',
    'lua_ls',
    'emmet_ls',
  }
}

-- Get cmp_nvim_lsp capabilities
local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Adding custom language server
if not configs.omnisharp_mono then
  configs.omnisharp_mono = {
    default_config = {
      cmd = { 'omnisharp-mono', '--languageserver', '--hostPID', tostring(vim.fn.getpid()) },
      filetypes = { 'cs' },
      root_dir = lspconfig.util.root_pattern('*.csproj', '*.sln', '.git'),
      settings = {}
    }
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
        monoPath = vim.fn.system { 'which', 'mono' }
      }
    }
  },

  lua_ls = {
    settings = {
      Lua = {
        diagnostics = {
          globals = {
            'vim', 'jit', 'color'
          }
        }
      }
    }
  },

  ansiblels = {
    filetypes = { 'yaml' },
    settings = {
      ansible = {
        validation = {
          lint = {
            enabled = false
          }
        }
      }
    }
  },

  tsserver = {
    -- filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'html', 'svelte' }
  },

  tailwindcss = {
    filetypes = { 'html', 'svelte', 'astro', 'vue' }
  },

  emmet_ls = {
    filetypes = { 'html', 'markdown', 'javascriptreact', 'typescriptreact', 'vue', 'astro', 'css', 'sass', 'scss',
      'less',
      'svelte' },
    init_options = {
      html = {
        options = {
          ['jsx.enabled'] = true
        }
      }
    }
  },

  volar = {
    filetypes = { 'javascript', 'typescript', 'vue' }
  }
}

-- note: omnisharp and omnisharp_mono shouldn't be insalled together

-- run setup() for every installed servers by mason, apply config if defined in lsp_options table
for _, server_name in ipairs(get_servers()) do
  -- get configurations from lsp_options table
  local settings = lsp_options[server_name] and lsp_options[server_name].settings or {}
  local filetypes = lsp_options[server_name] and lsp_options[server_name].filetypes or nil

  lspconfig[server_name].setup {
    filetypes = filetypes,
    settings = settings,
    capabilities = lsp_capabilities,
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
  group = lspGroup
})

-- Change diagnostic signs
local signs = {
  Error = '',
  Warn = '',
  Hint = '',
  Info = ''
}

for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
