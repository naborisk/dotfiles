-- TODO: add plugins keys in Lazy
-- bootstrapping lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require 'lazy'.setup {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    lazy = true,
    config = function()
      -- This is where you modify the settings for lsp-zero
      -- Note: autocompletion settings will not take effect

      require('lsp-zero.settings').preset({})
    end
  },
  

  -- Autocompletion
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-cmdline',
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      { 'L3MON4D3/LuaSnip' },
    },
    config = function()
      -- Here is where you configure the autocompletion settings.
      -- The arguments for .extend() have the same shape as `manage_nvim_cmp`:
      -- https://github.com/VonHeikemen/lsp-zero.nvim/blob/v2.x/doc/md/api-reference.md#manage_nvim_cmp

      require('lsp-zero.cmp').extend()

      -- And you can configure cmp even more, if you want to.
      local cmp = require('cmp')
      local cmp_action = require('lsp-zero.cmp').action()

      cmp.setup({
        preselect = 'item',
        completion = {
          completeopt = 'menu,menuone,noinsert'
        },
        sources = {
          {name = 'nvim_lsp'},
          {name = 'path'},
          {name = 'buffer', keyword_length = 3},
          {name = 'luasnip', keyword_length = 2}
        },
        mapping = {
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-f>'] = cmp_action.luasnip_jump_forward(),
          ['<C-b>'] = cmp_action.luasnip_jump_backward(),
          ['<cr>'] = cmp.mapping.confirm({ select = true }),
          ['<tab>'] = cmp.mapping(function(fallback)
            local col = vim.fn.col('.') - 1

            if cmp.visible() then
              cmp.select_next_item()
            elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
              fallback()
            else
              cmp.complete()
            end
          end, { 'i', 's' }),
          ['<s-tab>'] = cmp_action.select_prev_or_fallback()
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        }
      })
    end
  },

  -- LSP
  {
    'neovim/nvim-lspconfig',
    cmd = 'LspInfo',
    lazy = false,
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'williamboman/mason-lspconfig.nvim' },
      {
        'williamboman/mason.nvim',
        build = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
    },
    config = function()
      -- This is where all the LSP shenanigans will live

      local lsp = require('lsp-zero')

      lsp.on_attach(function(client, bufnr)
        lsp.default_keymaps({ buffer = bufnr })
      end)

      -- always show icon column
      vim.o.signcolumn = 'yes'

      lsp.preset('recommended')

      lsp.ensure_installed({
        'tsserver',
        'lua_ls',
        'emmet_ls'
      })

      lsp.configure('omnisharp', {
        settings = {
          omnisharp = {
            useModernNet = false,
            monoPath = '/Library/Frameworks/Mono.framework/Versions/Current/',
          }
        }
      })

      -- lsp.configure('lua_ls', {
      --   settings = {
      --     Lua = {
      --       diagnostics = {
      --         globals = {
      --           'vim', 'jit'
      --         }
      --       }
      --     }
      --   }
      -- })

      vim.diagnostic.config({
        virtual_text = false, -- show text after diagnostics
        signs = true,
        update_in_insert = false,
        underline = true,
        severity_sort = false,
        float = true,
      })

      lsp.configure('emmet_ls', {
        filetypes = { 'html', 'markdown', 'javascriptreact', 'typescriptreact', 'vue', 'astro', 'css', 'sass', 'scss', 'less' },
        init_options = {
          html = {
            options = {

            }
          }
        }
      })

      -- Show diagnostics text on cursor hold
      local lspGroup = vim.api.nvim_create_augroup('Lsp', { clear = true })

      vim.api.nvim_create_autocmd('CursorHold', {
        command = 'lua vim.diagnostic.open_float()',
        group = lspGroup
      })

      lsp.set_preferences({
        sign_icons = {
          error = '',
          warn = '',
          hint = '',
          info = ''
        }
      })
      -- (Optional) Configure lua language server for neovim
      require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

      lsp.setup()
    end
  },
  -- More completion
  -- Auto pairs
  'windwp/nvim-autopairs',

  -- Theme
  'EdenEast/nightfox.nvim',

  -- Comment
  'numToStr/Comment.nvim',

  -- Devicons
  'kyazdani42/nvim-web-devicons',

  -- Status line
  'feline-nvim/feline.nvim',

  -- Tabline
  'nanozuki/tabby.nvim',

  -- File explorer
  {
    'kyazdani42/nvim-tree.lua',
    dependencies = {
      'kyazdani42/nvim-web-devicons',
    }
  },

  'folke/which-key.nvim',

  -- Fuzzy finder
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.1',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      { '<leader>ft', ':Telescope<cr>' },
      { '<leader>ff', ':Telescope find_files<cr>' },
      { '<leader>fg', ':Telescope git_files<cr>' },
      { '<leader>fr', ':Telescope live_grep<cr>' },
    }
  },

  -- nvim-treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate'
  },
}
