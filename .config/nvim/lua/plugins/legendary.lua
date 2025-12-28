return {
	"mrjones2014/legendary.nvim",
	priority = 10000,
	lazy = false,
	dependencies = { "kkharji/sqlite.lua" }, -- Optional: helps with sorting by frequency
	opts = {
		extensions = { -- This is where the which_key setting moved to
			which_key = { auto_register = true },
		},
	},
	keys = {
		{ "<C-p>", "<cmd>Legendary<cr>", desc = "Search Keymaps/Commands" },
	},
}
