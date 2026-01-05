return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		preset = "helix",
		spec = {
			{ "<leader>,", group = "Format/LSP" },
			{ "<leader><tab>", group = "Tabs" },
			{ "<leader>A", group = "Applications" },
			{ "<leader>b", group = "Buffers" },
			{ "<leader>C", group = "Configurations" },
			{ "<leader>f", group = "Find" },
			{ "<leader>G", group = "Git" },
			{ "<leader>m", group = "Markers" },
			{ "<leader>n", group = "Notifications" },
			{ "<leader>q", group = "Session/Quit" }, -- Added for Persistence
			{ "<leader>r", group = "Iron/Refactor" },
			{ "<leader>s", group = "Search" },
			{ "<leader>t", group = "Terminal" },
			{ "<leader>T", group = "Toggles" },
			{ "<leader>w", group = "Windows" },
			{ "<leader>y", group = "Yank (MD)" },
			{ "z", group = "Folds" },
			{ "S", mode = "v", desc = "Add surround visual" },
		},
		plugins = {
			presets = {
				operators = true,
				motions = true,
				text_objects = true,
				windows = true,
				nav = true,
				z = true,
				g = true,
			},
		},
		win = {
			height = { max = 20 },
			border = "single",
			padding = { 0, 1 },
		},
		icons = {
			rules = false,
			separator = "→",
		},
		show_help = false,
	},
}
