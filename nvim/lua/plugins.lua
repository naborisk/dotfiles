-- TODO: add plugins keys in Lazy
-- bootstrapping lazy.nvim
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
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
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-cmdline',
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      { 'L3MON4D3/LuaSnip' },
    },
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
  },

  -- More completion
  -- Auto pairs, auto tags
  'windwp/nvim-autopairs',
  'windwp/nvim-ts-autotag',

  -- auto formatter
  {
    'nvimdev/guard.nvim',
    lazy = false,
  },

  -- Indentation lines
  {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      local color = color or 'duskfox'
      vim.cmd.colorscheme(color)
    end,
  },

  -- Theme
  'EdenEast/nightfox.nvim',

  -- Comment
  'numToStr/Comment.nvim',

  -- Devicons
  'kyazdani42/nvim-web-devicons',

  -- Heirline (Status line + Buffer line)
  'rebelot/heirline.nvim',

  -- File explorer
  {
    'kyazdani42/nvim-tree.lua',
    dependencies = {
      'kyazdani42/nvim-web-devicons',
    },
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
    },
  },

  -- nvim-treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
  },

  -- GitHub copilot
  {
    'github/copilot.vim',
  },

  -- git-blame
  {
    'f-person/git-blame.nvim',
  },
}, {
  -- Lazy options
  ui = {
    border = 'rounded',
  },
})
