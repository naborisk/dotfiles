local Perms = {
  provider = function()
    local path = vim.fn.expand('%:t')
    return vim.fn.system('/bin/ls -l ./' .. path .. ' | awk \'{print $1}\'')
  end,
}

return Perms
