return {
	{
		"mrcjkb/rustaceanvim",
		lazy = true,
		version = "^9",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"mfussenegger/nvim-dap",
		},
		ft = { "rust" },
		config = function()
			vim.g.rustaceanvim = {
				server = {
					on_attach = function()
						vim.lsp.inlay_hint.enable(true)
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
