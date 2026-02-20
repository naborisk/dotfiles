---- VARIABLES ----
local HOME = os.getenv 'HOME'
local USER = os.getenv 'USER'
local OS = jit.os -- "OSX" or "Linux"

---- PREREQUISITES ----
vim.o.termguicolors = true

-- neovide configuration
if vim.g.neovide then
  require 'neovide'
end

-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set leader key before plugins are loaded
vim.g.mapleader = ' '

---- LUA REQUIRE ----
-- plugins
require 'plugins'

-- filetypes based on filenames, etc.
require 'filetypes'

-- key bindings
require 'keybinds'

-- configurations
require 'configs'

-- cosmetics
require 'cosmetics'
