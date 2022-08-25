HOME = os.getenv("HOME")

require('plugins')

-- init.lua utility functions
function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, {noremap = true, silent = true})
end

---- ENABLED PLUGINS
-- feline
vim.o.tgc = true -- terminalguicolors is required by feline

-- nvim-tree
--require('nvim-tree').setup()

---- KEY MAPPINGS ----
-- toggle file explorer
map('n', '<C-b>', ':NvimTreeToggle<cr>')

-- esc in terminal mode
map('t', '<esc>', '<C-\\><C-n>')

---- OPTIONS ----
-- Show line number
vim.o.nu = true

-- Set tab size to 2 spaces and expandtab
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true

-- Search
vim.o.incsearch = true -- Highlight while searching
vim.o.ignorecase = true -- ignore letter case while searching
vim.o.smartcase = true -- case insensitive unless capitals used in search

-- enable mouse support
vim.o.mouse = 'a'

---- COSMETICS ----
-- colorscheme
vim.cmd('colorscheme nightfox')

-- Hide separators and end of buffer ~ and set VertSplit bg to be visible
vim.cmd [[
set fillchars=fold:\ ,vert:\ ,eob:\ ,msgsep:‾
hi VertSplit guibg=#141a23
]]

---- SCRIPTS ----
-- Save as superuser
vim.cmd [[
command W :execute ':silent w !sudo tee % > /dev/null' | :edit!
command WQ :execute ':silent w !sudo tee % > /dev/null' | :q!
]]

---- FUNCTIONS ----

