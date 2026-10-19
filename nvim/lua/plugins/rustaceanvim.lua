return {
	{
		"mrcjkb/rustaceanvim",
		version = "^9",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"mfussenegger/nvim-dap",
		},
		lazy = false,
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
