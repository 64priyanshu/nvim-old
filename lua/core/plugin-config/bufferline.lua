require("bufferline").setup({
  options = {
    event = "VimEnter",
    always_show_bufferline = false,
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        text_align = "center",
        padding = 1,
      },
    },
    sort_by = "insert_at_end",

    -- Diagnostics
    diagnostics = "nvim_lsp",
    diagnostics_update_on_event = true,
    diagnostics_indicator = function(count, level)
      local icon = level:match("error") and "E" or "W"
      return icon .. count
    end,
  },
})

-- Navigate Buffer
vim.keymap.set("n", "E", "<CMD>BufferLineCycleNext<CR>", { silent = true })
vim.keymap.set("n", "Q", "<CMD>BufferLineCyclePrev<CR>", { silent = true })

-- Reorder Buffers
vim.keymap.set("n", "<leader>E", "<CMD>BufferLineMoveNext<CR>", { silent = true })
vim.keymap.set("n", "<leader>Q", "<CMD>BufferLineMovePrev<CR>", { silent = true })
