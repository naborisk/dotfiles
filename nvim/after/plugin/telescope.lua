local builtin = require 'telescope.builtin'
local actions = require 'telescope.actions'

-- vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
-- vim.keymap.set('n', '<leader>fg', builtin.git_files, {})
-- vim.keymap.set('n', '<C-p>', builtin.find_files, {})

-- ripgrep required, grep string in files
-- vim.keymap.set('n', '<leader>fr', function()
--   builtin.live_grep {}
-- end)

require('telescope').setup {
  defaults = {
    layout_config = {
      vertical = { width = 0.3 },
    },
    mappings = {
      i = {
        ['<esc>'] = actions.close,
        ['<c-x>'] = actions.delete_buffer,
      },
    },
  },
  pickers = {
    find_files = {
      theme = 'dropdown',
    },
    live_grep = {
      theme = 'dropdown',
    },
  },
}
