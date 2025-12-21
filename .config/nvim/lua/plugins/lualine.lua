return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		-- NOTE: The global function _G.get_term_status() must be defined
		-- in your floating terminal configuration file for this to work.

		require("lualine").setup({
			options = {
				theme = "auto",
				-- Set a separator between sections for better visual grouping
				section_separators = { left = "", right = "" },
				component_separators = { left = "", right = "" },
			},
			sections = {
				-- Left side (Default: mode, filename)
				lualine_a = { "mode" },
				lualine_b = { "filename", "branch" },

				-- Center section (Default: LSP status)
				lualine_c = { "filetype", "lsp_progress" },

				-- Right side 1: Custom components
				lualine_x = {
					{
						function()
							return _G.get_term_status()
						end,
						-- Simplified condition: If the function exists, show it.
						cond = function()
							return type(_G.get_term_status) == "function" and _G.get_term_status() ~= ""
						end,
						color = { fg = "#ff9e64", gui = "bold" }, -- Made it bold for visibility
					},
					"encoding",
					"fileformat",
				},

				-- Right side 2 (Default: line and column)
				lualine_y = { "location" },
				lualine_z = { "progress" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
		})
	end,
}
