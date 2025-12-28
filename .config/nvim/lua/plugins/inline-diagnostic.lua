return {
	{
		"rachartier/tiny-inline-diagnostic.nvim",
		event = "VeryLazy",
		priority = 1000,
		config = function()
			-- 1. CONFIGURE THE INLINE "PILL" (The line-end view)
			require("tiny-inline-diagnostic").setup({
				preset = "modern",
				transparent_bg = false,
				hi = {
					background = "Normal", -- Base for blending
					mixing_color = "Normal", -- Creates the faint severity-colored tint
				},
				options = {
					-- Removes the "<-" arrow
					format = function(diagnostic)
						return " " .. diagnostic.message .. " "
					end,

					show_all_diags_on_cursorline = true,
					use_icons_from_diagnostic = true,

					softwrap = 60,
					multilines = {
						enabled = true,
						always_show = false,
					},
				},
			})

			-- 2. CONFIGURE THE FLOATING POP-UP (The 'gl' view)
			-- This styles the native Neovim floating window
			-- 1. Global Styling for the Float
			vim.diagnostic.config({
				virtual_text = false, -- Keep using tiny-inline for the end-of-line pill
				float = {
					border = "rounded",
					source = "always",
					header = "",
					prefix = "",
					-- This ensures the pop-up doesn't steal focus immediately
					focusable = false,
				},
			})

			-- 2. The Smart "Above" Keymap
			vim.keymap.set("n", "gl", function()
				vim.diagnostic.open_float(nil, {
					-- "SW" (South West) anchor pushes the window ABOVE the cursor
					anchor = "SW",
					-- Small offset to make it "float" slightly above the text
					row = -1,
					focusable = true,
				})
			end, { desc = "Show full diagnostic pop-up above line" })
		end,
	},
}
