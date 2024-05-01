local cmp = require("cmp")
local lspkind = require('lspkind')

require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
  mapping = cmp.mapping.preset.insert({
      ['<C-u>'] = cmp.mapping.scroll_docs(-4),
      ['<C-d>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = false}), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
  },
  window = {
    completion = cmp.config.window.bordered({
      border = "rounded",
    })
  },
  formatting = {
    format = lspkind.cmp_format({
      with_text = true,
      maxwidth = 50,
      menu = {
        buffer = '[BUF]',
        nvim_lsp = '[LSP]',
        nvim_lua = '[API]',
        path = '[PATH]',
        luasnip = '[SNIP]',
      },
    }),
  },
})
