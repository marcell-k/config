local FALLBACK_PYTHON = vim.fn.expand("~/.local/share/nvim-venv/bin/python")

return {
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				pyright = { enabled = false },
				basedpyright = { enabled = false },

				pyrefly = {
					before_init = function(_, config)
						local root = config.root_dir or vim.uv.cwd()
						local candidate = root .. "/.venv/bin/python"
						local python_path = vim.uv.fs_stat(candidate) and candidate or FALLBACK_PYTHON

						config.settings = vim.tbl_deep_extend("force", config.settings or {}, {
							python = { pythonPath = python_path },
						})
					end,
				},

				gopls = {},
				taplo = {
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
				},
			},
		},
	},
}
