local actions = require("telescope.actions")
local builtin = require("telescope.builtin")

require("telescope").setup({
	pickers = {
		live_grep = {
			file_ignore_patterns = { "node_modules", "%.git/", ".venv" },
			additional_args = function(_)
				return { "--hidden" }
			end,
		},
		colorscheme = {
			enable_preview = true,
		},
	},
	defaults = {
		mappings = {
			i = { -- Insert mode mappings
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
				["<a-k>"] = actions.preview_scrolling_up,
				["<a-j>"] = actions.preview_scrolling_down,
				["<Tab>"] = actions.select_default,
			},
			n = { -- Normal mode mappings
				["<a-k>"] = actions.preview_scrolling_up,
				["<a-j>"] = actions.preview_scrolling_down,
				["<Tab>"] = actions.select_default,
			},
		},
	},
})

-- Keymaps
vim.keymap.set("n", "<leader>ff", builtin.find_files, { silent = true })
vim.keymap.set("n", "<leader>ft", builtin.live_grep, { silent = true })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { silent = true })
vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { silent = true })
vim.keymap.set("n", "<leader>fh", builtin.highlights, { silent = true })
vim.keymap.set("n", "<leader>fc", builtin.colorscheme, { silent = true })

-- Telescope find files without preview
vim.keymap.set("n", "<leader>fp", function()
	builtin.find_files({
		previewer = false,
	})
end, { silent = true })

-- Telescope find files inside dotfiles
vim.keymap.set("n", "<leader>fd", function()
	builtin.find_files({
		hidden = true,
		file_ignore_patterns = { "node_modules", ".git", ".venv" },
		previewer = false,
	})
end, { silent = true })

-- Telescope search currently selected text
vim.keymap.set("v", "<leader>ft", "y<ESC>:Telescope live_grep default_text=<c-r>0<CR>", { silent = true })
