return {
	"nvim-neo-tree/neo-tree.nvim",
	init = function() end, -- overrides LazyVim's default init, kills the directory-autostart autocmd
	opts = {
		filesystem = {
			hijack_netrw_behavior = "disabled",
		},
	},
}
