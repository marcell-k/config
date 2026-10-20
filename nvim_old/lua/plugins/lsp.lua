return {
	{
		"neovim/nvim-lspconfig",
		opts = {
			diagnostics = {
				virtual_text = false,
				signs = false,
				underline = true,
				update_in_insert = false,
			},
			servers = {
				pyright = { enabled = false },
				basedpyright = { enabled = false },

				pyrefly = {
					enabled = false,
					before_init = function(_, config)
						local root = config.root_dir or vim.uv.cwd()
						local candidate = root .. "/.venv/bin/python"
						local python_path = vim.uv.fs_stat(candidate) and candidate or vim.g.python3_host_prog

						config.settings = vim.tbl_deep_extend("force", config.settings or {}, {
							python = { pythonPath = python_path },
						})
					end,
				},
				ty = {},
				ruff = {},
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
