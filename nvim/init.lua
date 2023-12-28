---- VARIABLES ----
HOME = os.getenv 'HOME'
USER = os.getenv 'USER'
OS = jit.os -- "OSX" or "Linux"

---- PREREQUISITES ----
vim.o.tgc = true

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
