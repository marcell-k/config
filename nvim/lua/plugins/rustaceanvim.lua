return {
	{
		"mrcjkb/rustaceanvim",
		version = "^9",
		lazy = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"mfussenegger/nvim-dap",
		},
		config = function()
			vim.g.rustaceanvim = {
				server = {
					on_attach = function(_, bufnr)
						vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })

						local function map(key, cmd, desc)
							vim.keymap.set("n", key, function()
								vim.cmd.RustLsp(cmd)
							end, {
								buffer = bufnr,
								desc = desc,
							})
						end

						map("<leader>rr", "runnables", "Runnables")
						map("<leader>rd", "debuggables", "Debuggables")
						map("<leader>rt", "testables", "Testables")
						map("<leader>rm", "expandMacro", "Expand macro")
					end,

					default_settings = {
						["rust-analyzer"] = {
							cargo = {
								features = "all",
							},
						},
					},
				},
			}
		end,
	},
}
