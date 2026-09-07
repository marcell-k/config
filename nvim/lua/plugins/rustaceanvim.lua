return {
	"mrcjkb/rustaceanvim",
	version = "^9",
	lazy = false, -- rustaceanvim handles its own lazy-loading on rust filetypes
	ft = { "rust" },
	init = function()
		vim.g.rustaceanvim = {
			server = {
				settings = {
					["rust-analyzer"] = {
						check = { command = "clippy" },
					},
				},
			},
		}
	end,
}
