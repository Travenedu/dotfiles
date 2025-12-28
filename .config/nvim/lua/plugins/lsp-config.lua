return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "williamboman/mason.nvim", opts = {} },
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		{ "j-hui/fidget.nvim", opts = {} },
		{ "folke/lazydev.nvim", ft = "lua", opts = {} },
	},
	config = function()
		-- 1. Setup Keymaps and Autocommands on Attach
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("user-lsp-attach", { clear = true }),
			callback = function(event)
				-- Renamed 'desc' to 'description' to avoid naming conflicts
				local map = function(keys, func, description)
					vim.keymap.set("n", keys, func, {
						buffer = event.buf,
						desc = "LSP: " .. (description or "No Description"),
					})
				end

				local fzf = require("fzf-lua")

				-- Keybinds
				map("gd", fzf.lsp_definitions, "Goto Definition")
				map("gr", fzf.lsp_references, "Goto References")
				map("gI", fzf.lsp_implementations, "Goto Implementation")
				map("K", vim.lsp.buf.hover, "Hover Documentation")

				-- Note: Changed <leader>rn to <leader>cr to match your which-key organization if desired
				map("<leader>rn", vim.lsp.buf.rename, "Rename")
				map("<leader>ca", vim.lsp.buf.code_action, "Code Action")

				-- Toggle Inlay Hints
				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if client and client.server_capabilities.inlayHintProvider then
					map("<leader>Th", function()
						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
					end, "Toggle Inlay Hints")
				end
			end,
		})

		-- 2. Capabilities for Blink.cmp
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

		-- 3. Load our external server list
		local lsp_servers = require("config.lsp-servers")
		local servers = lsp_servers.servers

		-- 4. Mason and Server Setup
		local ensure_installed = vim.tbl_keys(servers or {})
		vim.list_extend(ensure_installed, lsp_servers.ensure_installed)

		require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

		require("mason-lspconfig").setup({
			handlers = {
				function(server_name)
					local server = servers[server_name] or {}
					server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
					require("lspconfig")[server_name].setup(server)
				end,
			},
		})
	end,
}
