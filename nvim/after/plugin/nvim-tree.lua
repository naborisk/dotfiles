require('nvim-tree').setup {
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    icons = {
      error = '',
      warning = '',
      hint = '',
      info = '',
    },
  },
  view = {
    cursorline = true,
    signcolumn = 'yes',
  },
}
