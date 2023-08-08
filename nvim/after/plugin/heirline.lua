local conditions = require 'heirline.conditions'
local colors = require 'nightfox.palette'.load('nightfox')

-- components path
local components = 'nvim/after/plugin/heirline/'

local Align = {
  provider = "%="
}

local Space = {
  provider = " "
}

local Ruler = require(components .. 'ruler')
local ViMode = require(components .. 'vimode')
local LSPActive = require(components .. 'lspactive')
local Bufname = require(components .. 'bufname')
local FileType = require(components .. 'filetype')

local BufnameStatusLine = {
  condition = function()
    return conditions.buffer_matches({
      filetype = { 'NvimTree' }
    })
  end,
  FileType,
  Align
}

local SpecialStatusLine = {
  condition = function()
    return conditions.buffer_matches({
      buftype = { 'nofile', 'prompt', 'help', 'quickfix' },
      filetype = { '^git.*', 'fugitive' }
    })
  end,
  FileType,
  Space,
  Bufname,
  Align
}

local InactiveStatusLine = {
  condition = conditions.is_not_active,
  Bufname,
  Align
}

local DefaultStatusLine = {
  ViMode,
  Align,
  FileType,
  Space,
  LSPActive,
  Ruler,
  Space
}

-- arragement matters,
-- the first one that matches will be used
-- in this case, SpecialStatusLine will be used for inactive special buffers
local statusline = {
  fallthrough = false,
  BufnameStatusLine,
  SpecialStatusLine,
  InactiveStatusLine,
  DefaultStatusLine,
}

local winbar = {}
local tabline = {}

require 'heirline'.setup {
  statusline = statusline,
  -- winbar = winbar,
  -- tabline = tabline,
  opt = {
    colors = colors
  }
}
