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

			-- ty: always show variable-type hints, except giant Overload[...] signatures
			local inlay_handler = vim.lsp.handlers["textDocument/inlayHint"]

			vim.lsp.config("ty", {
				handlers = {
					["textDocument/inlayHint"] = function(err, result, ctx, config)
						result = vim.tbl_filter(function(hint)
							local label = hint.label
							if type(label) == "table" then
								label = table.concat(vim.tbl_map(function(p)
									return p.value
								end, label))
							end
							return not label:find("Overload[", 1, true)
						end, result or {})
						return inlay_handler(err, result, ctx, config)
					end,
				},
			})
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
			vim.lsp.enable({ "ty", "ruff", "gopls", "taplo", "lua_ls" })
		end,
	},
}
