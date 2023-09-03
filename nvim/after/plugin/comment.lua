require('Comment').setup()
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
