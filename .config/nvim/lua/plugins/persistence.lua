return {
	"folke/persistence.nvim",
	event = "BufReadPre", -- Load slightly earlier to ensure session state is ready
	opts = {
		-- Default directory is already ~/.local/share/nvim/sessions/
		-- Only change 'dir' if you want sessions saved elsewhere
		options = { "buffers", "curdir", "tabpages", "winsize", "skiprtp" },
	},
	keys = {
		-- Restore the session for the current directory
		{
			"<leader>qs",
			function()
				require("persistence").load()
			end,
			desc = "Restore Session (CWD)",
		},

		-- Select a session to load from a list
		{
			"<leader>qS",
			function()
				require("persistence").select()
			end,
			desc = "Select Session",
		},

		-- Restore the last session (regardless of CWD)
		{
			"<leader>ql",
			function()
				require("persistence").load({ last = true })
			end,
			desc = "Restore Last Session",
		},

		-- Stop Persistence (session won't be saved on exit)
		{
			"<leader>qd",
			function()
				require("persistence").stop()
			end,
			desc = "Don't Save Current Session",
		},
	},
}
