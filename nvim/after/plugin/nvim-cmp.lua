-- require 'lsp-zero'.extend_cmp()

-- And you can configure cmp even more, if you want to.
-- local cmp = require('cmp')
-- local cmp_action = require('lsp-zero.cmp').action()
--
-- cmp.setup {
--   preselect = 'item',
--   completion = {
--     completeopt = 'menu,menuone,noinsert'
--   },
--   sources = {
--     { name = 'nvim_lsp' },
--     { name = 'path' },
--     { name = 'buffer',  keyword_length = 3 },
--     { name = 'luasnip', keyword_length = 2 }
--   },
--   mapping = {
--     ['<C-c>'] = cmp_action.toggle_completion(),
--     ['<C-f>'] = cmp_action.luasnip_jump_forward(),
--     ['<C-b>'] = cmp_action.luasnip_jump_backward(),
--     ['<cr>'] = cmp.mapping.confirm({ select = true }),
--     -- TODO: fix race condition
--     ['<c-n>'] = cmp_action.luasnip_supertab(),
--     ['<c-p>'] = cmp_action.luasnip_shift_supertab()
--   },
--   window = {
--     completion = cmp.config.window.bordered(),
--     documentation = cmp.config.window.bordered(),
--   }
-- }

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
    ['<C-d>'] = cmp.mapping.scroll_docs(4), -- Down
    -- C-b (back) C-f (forward) for snippet placeholder navigation.
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  }
}
