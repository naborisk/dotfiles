-- local lsp = require'lsp-zero'
local lspconfig = require 'lspconfig'

-- Adding custom language server
local configs = require 'lspconfig.configs'

-- Get installed language servers from mason
local get_servers = require('mason-lspconfig').get_installed_servers

-- Get cmp_nvim_lsp capabilities
-- local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

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

-- lsp.ensure_installed({
--   'tsserver',
--   'lua_ls',
--   'emmet_ls',
-- })
--

-- lsp configurations
local lsp_options = {
  omnisharp_mono = {
    settings = {
      omnisharp = {
        useModernNet = false,
        -- TODO: allow for multiplatform
        monoPath = '/Library/Frameworks/Mono.framework/Versions/Current/',
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
  }
}

-- print(lsp_options['omnisharp_mono'].settings)

-- note: omnisharp and omnisharp_mono shouldn't be insalled together

-- run setup() for every installed servers by mason, apply config if defined in lsp_options table
for _, server_name in ipairs(get_servers()) do
  -- get settings from lsp_options table
  local settings = lsp_options[server_name] and lsp_options[server_name].settings or {}

  -- print(lsp_options[server_name])
  lspconfig[server_name].setup {
    -- settings = lsp_options[server_name].settings or {}
    settings = settings,
    -- capabilities = lsp_capabilities
  }
end

vim.diagnostic.config({
  virtual_text = false, -- show text after diagnostics
  signs = true,
  update_in_insert = false,
  underline = true,
  severity_sort = false,
  float = true,
})

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
