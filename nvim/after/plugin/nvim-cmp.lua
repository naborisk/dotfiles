require 'lsp-zero'.extend_cmp()

-- And you can configure cmp even more, if you want to.
local cmp = require('cmp')
local cmp_action = require('lsp-zero.cmp').action()

cmp.setup {
  preselect = 'item',
  completion = {
    completeopt = 'menu,menuone,noinsert'
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'path' },
    { name = 'buffer',  keyword_length = 3 },
    { name = 'luasnip', keyword_length = 2 }
  },
  mapping = {
    ['<C-c>'] = cmp_action.toggle_completion(),
    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
    ['<C-b>'] = cmp_action.luasnip_jump_backward(),
    ['<cr>'] = cmp.mapping.confirm({ select = true }),
    -- TODO: fix race condition
    ['<c-n>'] = cmp_action.luasnip_supertab(),
    ['<c-p>'] = cmp_action.luasnip_shift_supertab()
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  }
}
