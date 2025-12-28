return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"stevearc/aerial.nvim", -- Added dependency
	},
	config = function()
		require("lualine").setup({
			options = {
				theme = "auto",
				section_separators = { left = "", right = "" },
				component_separators = { left = "", right = "" },
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "filename", "branch" },

				-- Center section: Now includes the current function/method
				lualine_c = {
					"filetype",
					"lsp_progress",
					{
						"aerial",
						sep = " 󰿟 ", -- Separator between parent and child symbols
						depth = nil, -- Show all nesting (e.g., Class > Method)
					},
				},

				lualine_x = {
					{
						function()
							return _G.get_term_status()
						end,
						cond = function()
							return type(_G.get_term_status) == "function" and _G.get_term_status() ~= ""
						end,
						color = { fg = "#ff9e64", gui = "bold" },
					},
					"encoding",
					"fileformat",
				},
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
