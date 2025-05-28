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

-- copilot
-- disable tab mapping fot copilot
vim.g.copilot_no_tab_map = true
-- <c-g> for copilot accept (will append some binary if vim.keymap.set is used)
vim.api.nvim_set_keymap('i', '<c-g>', 'copilot#Accept("<cr>")', { expr = true, silent = true })

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

-- telescope
map('n', '<leader>ft', ':Telescope<cr>')
map('n', '<leader>ff', ':Telescope find_files<cr>')
map('n', '<leader>fg', ':Telescope git_files<cr>')
map('n', '<leader>fr', ':Telescope live_grep<cr>')

-- open buffer list with Telescope
map('n', '<leader>b', ':Telescope buffers<cr>')

map('n', '<leader>tt', ':Telescope<cr>')
map('n', '<c-y>', ':Telescope<cr>')
map('n', '<leader>tb', ':Telescope buffers<cr>')
map('n', '<leader>tr', ':Telescope lsp_references<cr>')
map('n', '<leader>td', ':Telescope lsp_definitions<cr>')

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
