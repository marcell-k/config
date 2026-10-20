return {
	{ "mason-org/mason.nvim", opts = {} },
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = { "neovim/nvim-lspconfig" },
		opts = { ensure_installed = { "ty", "ruff", "gopls", "taplo" } },
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			vim.diagnostic.config({ virtual_text = false, signs = false, underline = true })
			vim.lsp.enable({ "ty", "ruff", "gopls", "taplo" })
		end,
	},
}
