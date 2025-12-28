return {
	"stevearc/aerial.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	opts = {
		-- Priority: Use LSP first, then Treesitter
		backends = { "lsp", "treesitter", "markdown", "man" },

		layout = {
			max_width = { 40, 0.2 },
			min_width = 30,
			default_direction = "right",
			placement = "window",
		},

		-- Automatically close the outline when you jump to a symbol
		close_on_select = false,

		-- Show icons based on the type of symbol (Function, Class, etc.)
		show_guides = true,
	},
	keys = {
		-- Toggle the sidebar
		{ "<leader>o", "<cmd>AerialToggle!<CR>", desc = "Toggle [O]utline" },
		-- Jump between symbols quickly without opening the sidebar
		{ "{", "<cmd>AerialPrev<CR>", desc = "Previous Symbol" },
		{ "}", "<cmd>AerialNext<CR>", desc = "Next Symbol" },
	},
}
