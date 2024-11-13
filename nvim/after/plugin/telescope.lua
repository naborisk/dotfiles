local actions = require 'telescope.actions'

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
