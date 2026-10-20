return {
	{
		"stevearc/conform.nvim",
		opts = {
			default_format_opts = {
				timeout_ms = 3000,
				async = false,
				quiet = false,
				lsp_format = "fallback",
			},
			format_on_save = { timeout_ms = 3000, lsp_format = "fallback" },
			formatters_by_ft = {
				python = { "ruff_organize_imports", "ruff_format" },
				rust = { "rustfmt" },
				toml = { "taplo" },
				lua = { "stylua" },
			},
		},
	},
}
