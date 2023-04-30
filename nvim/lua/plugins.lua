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
  },

  -- LSP
  {
    'neovim/nvim-lspconfig',
    cmd = 'LspInfo',
    -- lazy = false,
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
