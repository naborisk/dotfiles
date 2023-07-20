---- VARIABLES ----
HOME = os.getenv("HOME")
OS = jit.os -- "OSX" or "Linux"

---- PREREQUISITES ----
vim.o.tgc = true -- terminalguicolors is required by feline

-- set leader key before plugins are loaded
vim.g.mapleader = ' '

-- init.lua utility functions
local function map(mode, shortcut, command)
  vim.keymap.set(mode, shortcut, command, { noremap = true, silent = true })
end

---- KEY MAPPINGS ----
-- format using prettier
-- map('n', '<leader>pf', ':%!prettier %:p<cr>')

-- unbind <c-n> and <c-p>
map('i', '<c-n>', '<nop>')
map('i', '<c-p>', '<nop>')

-- format using nvim lsp
map('n', '<leader>bf', ':lua vim.lsp.buf.format()<cr>') -- [b]uffer [f]ormat

-- toggle file explorer
map('n', '<C-b>', ':NvimTreeToggle<cr>')
map('i', '<C-b>', '<esc>:NvimTreeToggle<cr>')

-- esc in terminal mode
map('t', '<esc>', '<C-\\><C-n>')

-- cursor in place for page-moving
map('n', '<C-d>', '<C-d>zz')
map('n', '<C-u>', '<C-u>zz')

map('n', '<leader>m', ':Mason<cr>')

map('n', '<leader>L', ':Lazy<cr>')

-- change buffer using leader
map('n', '<leader>h', '<C-w>h')
map('n', '<leader>j', '<C-w>j')
map('n', '<leader>k', '<C-w>k')
map('n', '<leader>l', '<C-w>l')

map('n', '<leader>w', ':WhichKey<cr>')

-- add a CSS class
map('n', '<leader>ca', '0/class<cr>:noh<cr>2f"i')

---- LUA REQUIRE ----
-- load plugins after key mappings
require('plugins')

---- OPTIONS ----
-- Show line number
vim.o.nu = true

-- Show cursorline (highlights each line)
vim.o.cursorline = true

-- Set tab size to 2 spaces and expandtab
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true

-- Search
vim.o.incsearch = true  -- Highlight while searching
vim.o.ignorecase = true -- ignore letter case while searching
vim.o.smartcase = true  -- case insensitive unless capitals used in search
vim.o.hlsearch = true   -- highlight all search terms

-- enable mouse support
vim.o.mouse = 'a'

-- scrolloff makes sure that the bottom or top has a set amount of lines
vim.o.scrolloff = 6

-- low update time for diagnostics text
vim.o.ut = 400

-- use system clipboard
vim.o.clipboard = 'unnamedplus'

---- COSMETICS ----
-- colorscheme
-- vim.cmd('silent! colorscheme nightfox')
local color = color or 'duskfox' -- This makes sure to have colorscheme fallback
vim.cmd.colorscheme(color)

-- Hide separators and end of buffer ~ and set VertSplit bg to be visible
vim.cmd [[
set fillchars=fold:\ ,vert:\ ,eob:\ ,msgsep:‾
hi VertSplit guibg=#141a23
]]

---- SCRIPTS ----
-- Save as superuser

---- FUNCTIONS ----
