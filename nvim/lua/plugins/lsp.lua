return {
	{ "mason-org/mason.nvim", opts = {} },
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = { "mason-org/mason.nvim", "neovim/nvim-lspconfig" },
		opts = {
			ensure_installed = { "pyrefly", "ruff", "gopls", "taplo", "lua_ls" },
			automatic_enable = false,
		},
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			vim.diagnostic.config({ virtual_text = false, signs = false, underline = true })

			-- ruff
			vim.lsp.config("ruff", {
				on_attach = function(c)
					c.server_capabilities.hoverProvider = false
				end,
			})

			-- taplo
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
			vim.lsp.enable({ "pyrefly", "ruff", "gopls", "taplo", "lua_ls" })
		end,
	},
}
