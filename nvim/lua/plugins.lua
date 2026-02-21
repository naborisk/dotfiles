-- TODO: add plugins keys in Lazy
-- bootstrapping lazy.nvim
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  -- Autocompletion
  {
    'saghen/blink.cmp',
    version = '1.*',
    dependencies = {
      'rafamadriz/friendly-snippets',
      'giuxtaposition/blink-cmp-copilot',
    },
    opts = {
      keymap = {
        preset = 'none',
        ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<C-e>'] = { 'hide', 'fallback' },
        ['<CR>'] = { 'accept', 'fallback' },
        ['<Tab>'] = { 'select_next', 'fallback' },
        ['<S-Tab>'] = { 'select_prev', 'fallback' },
        ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
      },
      appearance = { nerd_font_variant = 'mono' },
      completion = {
        documentation = { auto_show = true, auto_show_delay_ms = 200 },
        menu = {
          draw = {
            columns = { { 'kind_icon' }, { 'label', 'label_description', gap = 1 }, { 'kind' } },
          },
        },
      },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer', 'copilot' },
        providers = {
          copilot = {
            name = 'copilot',
            module = 'blink-cmp-copilot',
            score_offset = 100,
            async = true,
          },
        },
      },
      fuzzy = { implementation = 'prefer_rust_with_warning' },
    },
    opts_extend = { 'sources.default' },
  },

  -- LSP
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason-lspconfig.nvim' },
      {
        'williamboman/mason.nvim',
        build = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
    },
  },

  -- Auto formatter
  {
    'stevearc/conform.nvim',
    event = 'BufWritePre',
    cmd = { 'ConformInfo' },
  },

  -- Snacks.nvim (indent, picker, notifier, etc.)
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = { enabled = true },
      indent = { enabled = true },
      notifier = { enabled = true },
      explorer = { enabled = true },
      picker = {
        win = {
          input = {
            keys = {
              ['<esc>'] = { 'close', mode = { 'n', 'i' } },
            },
          },
        },
        enabled = true,
        sources = {
          grep = {
            hidden = true,
            ignored = false,
          },
          explorer = {
            layout = { layout = { width = 30 } },
            win = {
              list = {
                keys = {
                  ['o'] = 'confirm',
                  ['s'] = 'explorer_open',
                  ['<C-b>'] = 'close',
                },
              },
            },
          },
        },
      },
      quickfile = { enabled = true },
      scope = { enabled = true },
    },
  },

  -- Theme
  {
    'EdenEast/nightfox.nvim',
    priority = 1000,
  },

  -- Heirline (Status line + Buffer line)
  'rebelot/heirline.nvim',

  {
    'SmiteshP/nvim-navic',
    event = 'LspAttach',
  },

  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
  },

  -- nvim-treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
      auto_install = true,
      highlight = { enable = true },
    },
  },

  -- Auto pairs, auto tags
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {},
  },
  {
    'windwp/nvim-ts-autotag',
    opts = {},
  },

  -- GitHub Copilot
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
  },

  -- git related stuffs
  {
    'lewis6991/gitsigns.nvim',
    event = 'BufReadPre',
  },
}, {
  -- Lazy options
  ui = {
    -- border = 'single',
  },
})
