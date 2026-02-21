---- COSMETICS ----
-- colorscheme is set in plugins.lua (nightfox config)

-- Hide separators and end of buffer ~ and set VertSplit bg to be visible
vim.o.fillchars = 'fold: ,vert: ,eob: ,msgsep:‾'

-- Highlight group
vim.api.nvim_set_hl(0, 'VertSplit', { link = 'Normal' })
vim.api.nvim_set_hl(0, 'NonText', { fg = '#39687a' })

-- Make background transparent
vim.api.nvim_set_hl(0, 'Normal', { ctermbg = 'None', bg = 'None' })
vim.api.nvim_set_hl(0, 'NormalNC', { ctermbg = 'None', bg = 'None' })

-- Customization for Pmenu
vim.api.nvim_set_hl(0, 'PmenuSel', { bg = '#282C34', fg = 'NONE' })
vim.api.nvim_set_hl(0, 'Pmenu', { fg = '#C5CDD9', bg = '#22252A' })
