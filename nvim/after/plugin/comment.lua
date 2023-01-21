require('Comment').setup()

-- comment using Ctrl + /
local api = require('Comment.api')
local esc = vim.api.nvim_replace_termcodes(
'<ESC>', true, false, true
)

vim.keymap.set('n', '<C-_>', api.toggle.linewise.current)
vim.keymap.set('x', '<C-_>', function()
  vim.api.nvim_feedkeys(esc, 'nx', false)
  api.toggle.linewise(vim.fn.visualmode())
end)

