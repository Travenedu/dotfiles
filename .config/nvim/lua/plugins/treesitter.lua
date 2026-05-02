return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	build = ":TSUpdate",
	config = function()
		-- 1. Ensure core parsers are installed without using the deprecated `configs` setup
		local ensure_installed = { "go", "cpp", "python", "javascript", "typescript" }
		
		-- Use pcall to ensure the config doesn't break if the install module is unavailable
		pcall(function()
			require("nvim-treesitter.install").ensure_installed(ensure_installed)
		end)

		-- 2. Start Treesitter natively for all filetypes safely
		vim.api.nvim_create_autocmd("FileType", {
			callback = function(args)
				pcall(vim.treesitter.start, args.buf)
			end,
		})
	end,
}

