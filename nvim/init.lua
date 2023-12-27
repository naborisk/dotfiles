---- VARIABLES ----
HOME = os.getenv 'HOME'
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

-- disable copilot tab mapping
vim.g.copilot_no_tab_map = true

---- LUA REQUIRE ----
-- load plugins after key mappings
require 'plugins'

-- load filetypes
require 'filetypes'

-- key bindings
require 'keybinds'

-- configurations
require 'configs'

---- COSMETICS ----
-- colorscheme
local color = color or 'nightfox' -- This makes sure to have colorscheme fallback
vim.cmd.colorscheme(color)

-- Hide separators and end of buffer ~ and set VertSplit bg to be visible
vim.o.fillchars = 'fold: ,vert: ,eob: ,msgsep:‾'

-- Highlight group
vim.api.nvim_set_hl(0, 'VertSplit', { link = 'NvimTreeNormal' })
vim.api.nvim_set_hl(0, 'NonText', { fg = '#39687a' })

-- Make background transparent
vim.api.nvim_set_hl(0, 'Normal', { ctermbg = 'None', bg = 'None' })
vim.api.nvim_set_hl(0, 'NormalNC', { ctermbg = 'None', bg = 'None' })
