---- OPTIONS ----
-- Show line number
vim.o.nu = true

-- Show cursorline (highlights each line)
vim.o.cursorline = true

-- Hide command line
vim.o.cmdheight = 1

-- Set tab size to 2 spaces and expandtab
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true

-- Search
vim.o.incsearch = true -- Highlight while searching
vim.o.ignorecase = true -- ignore letter case while searching
vim.o.smartcase = true -- case insensitive unless capitals used in search
vim.o.hlsearch = true -- highlight all search terms

-- enable mouse support
vim.o.mouse = 'a'

-- scrolloff makes sure that the bottom or top has a set amount of lines
vim.o.scrolloff = 6

-- low update time for diagnostics text
vim.o.ut = 400

-- use system clipboard
vim.o.clipboard = 'unnamedplus'

-- hide showmode
vim.o.showmode = false

-- persistent undo (by default undofile should be in ~/.local/state/nvim/undo)
vim.o.undofile = true

-- load NVIM Specific PATH from env
local NVIM_PATH = os.getenv 'NVIM_PATH'
if NVIM_PATH then
  vim.cmd("let $PATH='" .. NVIM_PATH .. ":'.$PATH")
end
