require('nvim-treesitter.configs').setup {
  auto_install = true,
  highlight = {
    enable = true,
    disable = {
      'lua',
      'vue',
    },
  },
  autotag = {
    enable = true,
  },
}
