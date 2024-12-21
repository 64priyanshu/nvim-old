local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>sf", builtin.find_files, { silent = true })
vim.keymap.set("n", "<leader>st", builtin.live_grep, { silent = true })
vim.keymap.set("n", "<leader>sb", builtin.buffers, { silent = true })
vim.keymap.set("n", "<leader>sr", builtin.oldfiles, { silent = true })
vim.keymap.set("n", "<leader>sh", builtin.highlights, { silent = true })
vim.keymap.set("n", "<leader>sc", builtin.colorscheme, { silent = true })

-- Telescope find files without preview
vim.keymap.set("n", "<leader>ff", function()
	builtin.find_files({
		previewer = false,
	})
end, { silent = true })

-- Telescope search currently selected text
vim.keymap.set("v", "<leader>st", "y<ESC>:Telescope live_grep default_text=<c-r>0<CR>", { silent = true })

require("telescope").setup({
	pickers = {
		colorscheme = {
			enable_preview = true,
		},
	},
	defaults = {
		mappings = {
			i = { -- Insert mode mappings
				["<C-j>"] = require("telescope.actions").move_selection_next,
				["<C-k>"] = require("telescope.actions").move_selection_previous,
				["<a-k>"] = require("telescope.actions").preview_scrolling_up,
				["<a-j>"] = require("telescope.actions").preview_scrolling_down,
				["<Tab>"] = require("telescope.actions").select_default,
			},
			n = { -- Normal mode mappings (optional)
				["<a-k>"] = require("telescope.actions").preview_scrolling_up,
				["<a-j>"] = require("telescope.actions").preview_scrolling_down,
				["<Tab>"] = require("telescope.actions").select_default,
			},
		},
	},
})
