require('ts_context_commentstring').setup {
  enable_autocmd = false,
}

require('Comment').setup {
  pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
}
local ft = require 'Comment.ft'

-- comment using Ctrl + /
local api = require 'Comment.api'
local esc = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)

vim.keymap.set('n', '<C-_>', api.toggle.linewise.current)
vim.keymap.set('i', '<C-_>', api.toggle.linewise.current)
vim.keymap.set('x', '<C-_>', function()
  vim.api.nvim_feedkeys(esc, 'nx', false)
  api.toggle.linewise(vim.fn.visualmode())
end)

-- Add unsupported filetypes
ft.set('astro', '<!--%s-->')
ft.set('hcl', '# %s')
