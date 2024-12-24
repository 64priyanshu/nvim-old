-- Change Insert-mode cursor to a block cursor
vim.opt.guicursor = {
	"n-v-c:block",
	"i-ci:block-blinkon1",
	"r-o:hor20",
}

vim.opt.undodir = (os.getenv("USERPROFILE") or os.getenv("HOME")) .. "/.vim/undodir" -- Store undofiles in this directory (USERPROFILE for Win, HOME for Linux)

-- Instead of 4, use 2 spaces as (auto)indentation
vim.api.nvim_create_autocmd("FileType", {
	pattern = "python",
	command = "setlocal tabstop=2 shiftwidth=2 expandtab",
})

-- Prevent from automatically inserting comment leader when opening new line under a comment
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*",
	command = "setlocal formatoptions-=cro",
})

-- Print startuptime on entering Neovim
local start_time = vim.fn.reltime()

vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		local elapsed = vim.fn.reltimefloat(vim.fn.reltime(start_time)) * 1000 -- Convert to milliseconds
		print("Startup time: " .. string.format("%.3f ms", elapsed))
	end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	pattern = "*",
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Go to the last location when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})
