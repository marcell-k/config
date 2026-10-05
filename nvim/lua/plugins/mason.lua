return {
	{
		"mason-org/mason.nvim",
		opts = {},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {
			ensure_installed = {
				"clangd",
				"gopls",
				"pyrefly",
				"ruff",
				"taplo",
			},
		},
	},
}
