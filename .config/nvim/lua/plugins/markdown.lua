return {
	"MeanderingProgrammer/render-markdown.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.icons" },
	---@module 'render-markdown'
	---@type render.md.UserConfig
	opts = {
		-- 1. Minimalist Headers (Text only, no full-line background)
		heading = {
			enabled = true,
			sign = true,
			position = "overlay",
			icons = { "◉ ", "○ ", "✸ ", "✿ ", "󰛢 ", "󰛣 " },
			-- This is the key: it disables the full-width background bar
			backgrounds = {},
			-- This ensures only the text/icon gets the highlight
			foregrounds = {
				"RenderMarkdownH1",
				"RenderMarkdownH2",
				"RenderMarkdownH3",
				"RenderMarkdownH4",
				"RenderMarkdownH5",
				"RenderMarkdownH6",
			},
		},
		-- 2. Code Blocks with Arctic Borders
		code = {
			enabled = true,
			style = "full", -- Draws the top/bottom lines
			width = "block", -- Box fits the code width
			border = "thin", -- Sharp VS Code-style lines
			left_pad = 2,
			right_pad = 2,
		},
		-- 3. Clean Checkboxes
		checkbox = {
			unchecked = { icon = "󰄱 " },
			checked = { icon = " " },
		},
		-- 4. Color Logic (Matching Arctic.nvim)
		highlights = {
			heading = {
				-- We link to Arctic's native groups so they match perfectly
				level_1 = { link = "Function" }, -- Arctic Blue
				level_2 = { link = "Type" }, -- Arctic Teal
				level_3 = { link = "Constant" }, -- Arctic Light Blue
				level_4 = { link = "Identifier" }, -- Arctic White
			},
			code = {
				background = "ColorColumn", -- Subtle grey-blue background
				border = { link = "FloatBorder" }, -- Window-style border color
			},
			bullet = { link = "Character" }, -- Arctic Green
			checkbox = {
				unchecked = { link = "Comment" }, -- Muted grey
				checked = { link = "String" }, -- Arctic Green
			},
			dash = { link = "Comment" }, -- Subtle horizontal separators
			pipe = { link = "Conceal" }, -- Clean table borders
		},
	},
}
