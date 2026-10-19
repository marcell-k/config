return {
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {
			ensure_installed = {
				-- "clangd",
				"gopls",
				"pyrefly",
				"ruff",
				"taplo",
			},
		},
	},
}
