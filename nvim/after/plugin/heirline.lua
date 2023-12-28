-- add components folder to path to package.path
HOME = os.getenv 'HOME'
package.path = HOME .. '/.config/nvim/after/plugin/heirline/?.lua;' .. package.path

local conditions = require 'heirline.conditions'
local utils = require 'heirline.utils'
-- local colors = require('nightfox.palette').load 'nightfox'

local colors = {
  fg = utils.get_highlight('StatusLine').fg,
  bg = utils.get_highlight('StatusLine').bg,
  fg_inactive = utils.get_highlight('StatusLineNC').fg,
  bg_inactive = utils.get_highlight('StatusLineNC').bg,
  bright_bg = utils.get_highlight('Folded').bg,
  bright_fg = utils.get_highlight('Folded').fg,
  red = utils.get_highlight('DiagnosticError').fg,
  dark_red = utils.get_highlight('DiffDelete').bg,
  green = utils.get_highlight('String').fg,
  blue = utils.get_highlight('Function').fg,
  gray = utils.get_highlight('NonText').fg,
  orange = utils.get_highlight('Constant').fg,
  purple = utils.get_highlight('Statement').fg,
  cyan = utils.get_highlight('Special').fg,
  diag_warn = utils.get_highlight('DiagnosticWarn').fg,
  diag_error = utils.get_highlight('DiagnosticError').fg,
  diag_hint = utils.get_highlight('DiagnosticHint').fg,
  diag_info = utils.get_highlight('DiagnosticInfo').fg,
  git_del = utils.get_highlight('diffRemoved').fg,
  git_add = utils.get_highlight('diffAdded').fg,
  git_change = utils.get_highlight('diffChanged').fg,
}

local Align = {
  provider = '%=',
}

local Space = {
  provider = ' ',
}

local Ruler = require 'ruler'
local ViMode = require 'vimode'
local LSPActive = require 'lspactive'
local Bufname = require 'bufname'
local FileType = require 'filetype'
local FileName = require 'filename'
local FullPath = require 'fullpath'
local Git = require 'git'
local Navic = require 'navic'

local BufnameStatusLine = {
  condition = function()
    return conditions.buffer_matches {
      filetype = { 'NvimTree' },
    }
  end,
  Space,
  FileType,
  Align,
  hl = {
    bg = 'bg',
  },
}

local SpecialStatusLine = {
  condition = function()
    return conditions.buffer_matches {
      buftype = { 'nofile', 'prompt', 'help', 'quickfix' },
      filetype = { '^git.*', 'fugitive' },
    }
  end,
  Space,
  FileType,
  Space,
  Bufname,
  Align,
  hl = {
    bg = 'bg',
  },
}

local InactiveStatusLine = {
  condition = conditions.is_not_active,
  Space,
  Space,
  Space,
  FullPath,
  Align,
  FileType,
  Space,
  Ruler,
  Space,
  LSPActive,
  Space,
  hl = {
    bg = 'bg_inactive',
    fg = 'fg_inactive',
  },
}

local DefaultStatusLine = {
  ViMode,
  Align,
  Git,
  Space,
  FileType,
  Space,
  Ruler,
  Space,
  LSPActive,
  Space,
  hl = {
    bg = 'bg',
  },
}

local DefaultWinBar = {
  Space,
  Space,
  Space,
  FileName,
  Space,
  Navic,
  Align,
}

local SpecialWinBar = {
  condition = function()
    return conditions.buffer_matches {
      buftype = { 'nofile', 'prompt', 'help', 'quickfix' },
      filetype = { '^git.*', 'fugitive' },
    }
  end,
  {
    provider = '',
  },
}

-- order matters,
-- the first one that matches will be used
-- in this case, SpecialStatusLine will be used for inactive special buffers
local statusline = {
  fallthrough = false,
  BufnameStatusLine,
  SpecialStatusLine,
  InactiveStatusLine,
  DefaultStatusLine,
}

local winbar = {
  fallthrough = false,
  SpecialWinBar,
  DefaultWinBar,
}

-- local tabline = {}
require('heirline').setup {
  statusline = statusline,
  winbar = winbar,
  -- tabline = tabline,
  opts = {
    colors = colors,
  },
}
