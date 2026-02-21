vim.filetype.add {
  filename = {
    ['.prettierrc'] = 'yaml',
    ['aliases'] = 'bash',
    ['user-data'] = 'yaml',
    ['meta-data'] = 'yaml',
    ['config'] = 'config',
    ['.zshenv'] = 'sh',
  },
  pattern = {
    ['.*compose.*.y[a]?ml'] = 'yaml.docker-compose',
    ['playbook.y[a]?ml'] = 'yaml.ansible',
    ['.env.*'] = 'sh',
    ['.sh'] = 'bash',
  },
}

-- Custom commentstring for filetypes not covered by treesitter
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'astro' },
  callback = function()
    vim.bo.commentstring = '<!--%s-->'
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'hcl' },
  callback = function()
    vim.bo.commentstring = '# %s'
  end,
})
