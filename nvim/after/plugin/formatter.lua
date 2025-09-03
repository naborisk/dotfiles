-- local util = require 'formatter.util'

require('formatter').setup {
  logging = false,
  log_level = vim.log.levels.WARN,
  filetype = {
    lua = {
      require('formatter.filetypes.lua').stylua,
    },

    javascript = {
      require('formatter.filetypes.javascript').prettier,
      require('formatter.filetypes.javascript').eslint_d,
      require('formatter.filetypes.typescriptreact').biome,
    },

    javascriptreact = {
      require('formatter.filetypes.javascriptreact').prettier,
      require('formatter.filetypes.javascriptreact').eslint_d,
      require('formatter.filetypes.typescriptreact').biome,
    },

    typescriptreact = {
      require('formatter.filetypes.typescriptreact').prettier,
      require('formatter.filetypes.typescriptreact').eslint_d,
      require('formatter.filetypes.typescriptreact').biome,
    },

    typescript = {
      require('formatter.filetypes.typescript').prettier,
      require('formatter.filetypes.typescript').eslint_d,
      require('formatter.filetypes.typescriptreact').biome,
    },

    svelte = {
      require('formatter.filetypes.svelte').prettier,
    },

    vue = {
      require('formatter.filetypes.vue').prettier,
      require('formatter.filetypes.typescript').eslint_d,
    },

    css = {
      require('formatter.filetypes.css').prettier,
    },

    yaml = {
      require('formatter.filetypes.yaml').prettier,
    },

    json = {
      require('formatter.filetypes.typescriptreact').biome,
    },

    terraform = {
      require('formatter.filetypes.terraform').terraformfmt,
    },

    go = {
      require('formatter.filetypes.go').gofmt,
    },

    rust = {
      require('formatter.filetypes.rust').rustfmt,
    },

    html = {
      require('formatter.filetypes.html').prettier,
    },

    sh = {
      require('formatter.filetypes.sh').shfmt,
    },

    zsh = {
      require('formatter.filetypes.zsh').beautysh,
    },

    bash = {
      require('formatter.filetypes.zsh').beautysh,
    },

    xml = {
      require('formatter.filetypes.xml').xmlformat,
    },

    -- ['*'] = {
    --   require('formatter.filetypes.any').remove_trailing_whitespace,
    -- },
  },
}

-- Toggleable formatter
local NVIM_FORMATTER_DISABLED = os.getenv 'NVIM_FORMATTER_DISABLED'

if not NVIM_FORMATTER_DISABLED then
  vim.cmd [[
  augroup FormatAutogroup
    autocmd!
    autocmd BufWritePost * FormatWrite
  augroup END
  ]]
end
