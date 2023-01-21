local builtin = require('telescope.builtin')
local actions = require('telescope.actions')

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.git_files, {})

-- ripgrep required, grep string in files
vim.keymap.set('n', '<leader>rg', function()
  builtin.grep_string({search = vim.fn.input("Grep > ")})
end
)

require('telescope').setup({
  defaults = {
    mappings = {
      i = {
        ['<esc>'] = actions.close,
      }
    }
  }
})
