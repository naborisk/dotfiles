vim.filetype.add {
  filename = {
    ['.prettierrc'] = 'yaml',
    ['aliases'] = 'bash',
    ['user-data'] = 'yaml',
    ['meta-data'] = 'yaml',
    ['config'] = 'json',
  },
  pattern = {
    ['.*compose.*.y[a]?ml'] = 'yaml.docker-compose',
    ['playbook.y[a]?ml'] = 'yaml.ansible',
  },
}
