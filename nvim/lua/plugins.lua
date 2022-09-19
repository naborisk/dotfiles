-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
--vim.cmd [[packadd packer.nvim]]

-- Auto compile plugins
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  -- Theme
  use 'EdenEast/nightfox.nvim'

  -- Language Server
  use {
    'neovim/nvim-lspconfig',
    config = function()
      require'lspconfig'.pyright.setup{}
      require'lspconfig'.tsserver.setup{}
      require'lspconfig'.volar.setup{
        init_options = {
          typescript = {
            serverPath = os.getenv('HOME')..'/.nvm/versions/node/v16.14.0/lib/node_modules/typescript/lib/tsserverlibrary.js'
            -- Alternative location if installed as root:
            -- serverPath = '/usr/local/lib/node_modules/typescript/lib/tsserverlibrary.js'
          }
        }
      }
    end
  }
  use {
    'ms-jpq/coq_nvim',
    config = function()
      vim.g.coq_settings = {
        auto_start = 'shut-up'
      }
    end
  }
  use {'ms-jpq/coq.artifacts', branch = 'artifacts'}

  -- Auto completion

  -- Devicons
  use 'kyazdani42/nvim-web-devicons'

  -- Status line
  use {
    'feline-nvim/feline.nvim',
    config = function()
      require('feline').setup()
    end
  }

  -- Tabline

  -- File explorer
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons',
    },
    config = function()
      require('nvim-tree').setup()
    end
  }

end)
