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
    },

    svelte = {
      require('formatter.filetypes.svelte').prettier,
    },

    vue = {
      require('formatter.filetypes.vue').prettier,
    },

    ['*'] = {
      require('formatter.filetypes.any').remove_trailing_whitespace,
    },
  },
}

vim.cmd [[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost * FormatWrite
augroup END
]]
