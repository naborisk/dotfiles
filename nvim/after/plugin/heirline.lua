-- add components folder to path to package.path
HOME = os.getenv("HOME")
package.path = HOME..'/.config/nvim/after/plugin/heirline/?.lua;' .. package.path

local conditions = require 'heirline.conditions'
local colors = require 'nightfox.palette'.load('nightfox')

local Align = {
  provider = "%="
}

local Space = {
  provider = " "
}

local Ruler = require('ruler')
local ViMode = require('vimode')
local LSPActive = require('lspactive')
local Bufname = require('bufname')
local FileType = require('filetype')
local FileName = require('filename')

local BufnameStatusLine = {
  condition = function()
    return conditions.buffer_matches({
      filetype = { 'NvimTree' }
    })
  end,
  Space,
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
  Space,
  FileType,
  Space,
  Bufname,
  Align
}

local InactiveStatusLine = {
  condition = conditions.is_not_active,
  Space,
  Space,
  Space,
  FileName,
  Align
}

local DefaultStatusLine = {
  ViMode,
  Align,
  Space,
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

local winbar = {
  Space,
  FileName,
  Align,
}

local tabline = {}

require 'heirline'.setup {
  statusline = statusline,
  winbar = winbar,
  -- tabline = tabline,
  opt = {
    colors = colors
  }
}
