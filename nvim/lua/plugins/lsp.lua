return {
	{ "mason-org/mason.nvim", opts = {} },
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = { "neovim/nvim-lspconfig" },
		opts = { ensure_installed = { "ty", "ruff", "gopls", "taplo", "lua_ls" } },
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			vim.diagnostic.config({ virtual_text = false, signs = false, underline = true })
			vim.lsp.config("ruff", {
				on_attach = function(c)
					c.server_capabilities.hoverProvider = false
				end,
			})
			vim.lsp.config("taplo", {
				settings = {
					evenBetterToml = {
						fmt = {
							columnWidth = 100,
							arrayAutoCollapse = true,
							arrayAutoExpand = true,
							arrayTrailingComma = false,
						},
					},
				},
			})
			vim.lsp.enable({ "ty", "ruff", "gopls", "taplo", "lua_ls" })
		end,
	},
}
