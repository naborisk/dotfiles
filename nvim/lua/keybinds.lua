---- KEY MAPPINGS ----

-- utility functions
local function map(mode, shortcut, command)
  vim.keymap.set(mode, shortcut, command, { noremap = true, silent = true })
end

-- format using prettier
map('n', '<leader>pf', ':%!prettier %:p<cr>')

-- unbind <c-n> and <c-p>
map('i', '<c-n>', '<nop>')
map('i', '<c-p>', '<nop>')

-- format using nvim lsp
-- map('n', '<leader>bf', ':lua vim.lsp.buf.format()<cr>') -- [b]uffer [f]ormat
-- map('n', '<leader>bf', ':FormatWrite<cr>')

-- toggle file explorer
map('n', '<C-b>', ':NvimTreeToggle<cr>')
map('i', '<C-b>', '<esc>:NvimTreeToggle<cr>')

-- esc in terminal mode
map('t', '<esc>', '<C-\\><C-n>')

-- cursor in place for page-moving
map('n', '<C-d>', '<C-d>zz')
map('n', '<C-u>', '<C-u>zz')

map('n', '<leader>m', ':Mason<cr>')

map('n', '<leader>La', ':Lazy<cr>')
map('n', '<leader>Ls', ':LspInfo<cr>')

-- change buffer using leader
map('n', '<leader>h', '<C-w>h')
map('n', '<leader>j', '<C-w>j')
map('n', '<leader>k', '<C-w>k')
map('n', '<leader>l', '<C-w>l')

map('n', '<leader>w', ':WhichKey<cr>')

-- add a CSS class
map('n', '<leader>ac', '0/class<cr>:noh<cr>2f"i')

-- Code action
map('n', '<leader>ca', ':lua vim.lsp.buf.code_action()<cr>')

-- snacks.picker
map('n', '<leader>ft', function()
  Snacks.picker()
end)
map('n', '<leader>ff', function()
  Snacks.picker.files()
end)
map('n', '<leader>fg', function()
  Snacks.picker.git_files()
end)
map('n', '<leader>fr', function()
  Snacks.picker.grep()
end)

-- open buffer list with Snacks
map('n', '<leader>b', function()
  Snacks.picker.buffers()
end)

map('n', '<leader>tt', function()
  Snacks.picker()
end)
map('n', '<c-y>', function()
  Snacks.picker()
end)
map('n', '<leader>tb', function()
  Snacks.picker.buffers()
end)
map('n', '<leader>tr', function()
  Snacks.picker.lsp_references()
end)
map('n', '<leader>td', function()
  Snacks.picker.lsp_definitions()
end)

-- Obsidian.nvim
map('n', '<leader>ot', ':ObsidianToday<cr>')
map('n', '<leader>oc', ':ObsidianTOC<cr>')
map('n', '<leader>of', ':ObsidianFollowLink<cr>')

-- GitHub
map('n', '<leader>gb', ':!gh browse --branch $(git branch --show-current) %:.<cr>')
map('n', '<leader>gl', ':exec "!gh browse --branch $(git branch --show-current) \\"%\\":".line(".")<cr>')

-- buffer management
map('n', '<c-l>', ':bnext<cr>')
map('n', '<c-h>', ':bprevious<cr>')
map('n', '<c-q>', ':bdelete<cr>')
