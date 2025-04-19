require("gruvbox").setup({
  overrides = {
    SignColumn = { bg = "NONE" },
    FoldColumn = { bg = "NONE" },
    NormalFloat = { bg = "#32302f" },
    FloatBorder = { fg = "#7e7764", bg = "#32302f" },
  },
})
-- Enabling colorscheme
vim.cmd("colorscheme gruvbox")
