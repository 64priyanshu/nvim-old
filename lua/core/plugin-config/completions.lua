local cmp = require("cmp")
local luasnip = require("luasnip")

-- Load Friendly Snippets
require("luasnip.loaders.from_vscode").lazy_load()
-- Load Custom Snippets
require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.fn.stdpath("config") .. "/snippets" } })

cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
    ["<C-d>"] = cmp.mapping.scroll_docs(4),
    ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
    ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<Tab>"] = cmp.mapping.confirm({ select = false }),
  }),
  completion = {
    completeopt = "menu,menuone",
  },
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
    { name = "nvim_lua" },
  },
  formatting = {
    fields = { "abbr", "kind", "menu" },
    format = function(entry, vim_item)
      local kind_icons = {
        Text = "󰉿",
        Method = "󰆧",
        Function = "󰊕",
        Constructor = "",
        Field = "󰜢",
        Variable = "󰀫",
        Class = "󰠱",
        Interface = "",
        Module = "",
        Property = "󰜢",
        Unit = "󰑭",
        Value = "󰎠",
        Enum = "",
        Keyword = "󰌋",
        Snippet = "",
        Color = "󰏘",
        File = "󰈙",
        Reference = "󰈇",
        Folder = "󰉋",
        EnumMember = "",
        Constant = "󰏿",
        Struct = "󰙅",
        Event = "",
        Operator = "󰆕",
        TypeParameter = "󰊄",
      }
      -- vim_item.abbr = vim_item.abbr:match("[^(]+") -- [[ fun(foo, bar) -> fun ]]
      -- vim_item.abbr = vim_item.abbr:gsub("%b()", "()") -- [[ -> fun(foo, bar) -> fun() ]]
      vim_item.kind = kind_icons[vim_item.kind] .. " " .. vim_item.kind
      vim_item.menu = ({
        buffer = "[BUF]",
        nvim_lsp = "[LSP]",
        nvim_lua = "[API]",
        luasnip = "[SNIP]",
        path = "[PATH]",
      })[entry.source.name]

      if
        entry.source.name == "nvim_lsp"
        and entry.completion_item.labelDetails
        and entry.completion_item.labelDetails.detail
      then
        vim_item.menu = vim_item.menu .. entry.completion_item.labelDetails.detail
      end

      return vim_item
    end,
  },
})

-- Luasnip
vim.keymap.set({ "i" }, "<C-l>", function()
  luasnip.expand()
end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-f>", function()
  luasnip.jump(1)
end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-b>", function()
  luasnip.jump(-1)
end, { silent = true })
vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
  if luasnip.choice_active() then
    luasnip.change_choice(1)
  end
end, { silent = true })

-- luasnip.filetype_extend("destination", { "source1", "source2", ... })
luasnip.filetype_extend("php", { "html" })
