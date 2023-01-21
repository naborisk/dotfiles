require'nvim-tree'.setup {
  diagnostics = {
    enable = true,
    show_on_dirs = true
  },
  view = {
    cursorline = true,
    signcolumn = 'yes'
  }
}

vim.cmd[[
  hi link NvimTreeCursorLine Cursor
]]
