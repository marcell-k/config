return {
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				python = { "ruff_organize_imports", "ruff_format" },
				go = { "goimports", "gofmt" },
				rust = { "rustfmt" },
				toml = { "taplo" },
				c = { "clang-format" },
			},
			formatters = {},
		},
	},
}
