require('conform').setup {
  formatters_by_ft = {
    lua = { 'stylua' },
    javascript = { 'prettier', 'eslint_d', 'biome' },
    javascriptreact = { 'prettier', 'eslint_d', 'biome' },
    typescriptreact = { 'prettier', 'eslint_d', 'biome' },
    typescript = { 'prettier', 'eslint_d', 'biome' },
    svelte = { 'prettier' },
    vue = { 'prettier', 'eslint_d' },
    css = { 'prettier' },
    yaml = { 'prettier' },
    json = { 'biome' },
    terraform = { 'terraform_fmt' },
    go = { 'gofmt' },
    rust = { 'rustfmt' },
    html = { 'prettier' },
    sh = { 'shfmt' },
    zsh = { 'beautysh' },
    bash = { 'beautysh' },
    xml = { 'xmlformat' },
  },
  format_on_save = function(bufnr)
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      return
    end
    return { timeout_ms = 500, lsp_format = 'fallback' }
  end,
}

-- For the format status on statusline
local function notify_format_status()
  vim.api.nvim_exec_autocmds('User', { pattern = 'FormatStatusChanged' })
end

vim.api.nvim_create_user_command('FormatDisable', function(args)
  if args.bang then
    vim.b.disable_autoformat = true
  else
    vim.g.disable_autoformat = true
  end
  notify_format_status()
end, { desc = 'Disable autoformat-on-save', bang = true })

vim.api.nvim_create_user_command('FormatEnable', function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
  notify_format_status()
end, { desc = 'Re-enable autoformat-on-save' })
