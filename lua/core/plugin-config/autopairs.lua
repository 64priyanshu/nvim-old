-- Autopairs
require("nvim-autopairs").setup({
	options = {
		event = "InsertEnter",
	},
	check_ts = true,
})

local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local cmp = require("cmp")

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
