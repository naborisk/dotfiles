local conditions = require 'heirline.conditions'

local GitUser = {
  condition = conditions.is_git_repo,

  init = function(self)
    self.git_name = vim.fn.system { 'git', 'config', 'user.name' }
  end,

  hl = { fg = 'orange' },

  {
    provider = function(self)
      return self.git_name:match("^%s*(.-)%s*$") -- trim whitespace
    end,
  },
}

return GitUser
