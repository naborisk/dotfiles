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
