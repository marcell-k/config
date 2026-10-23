return {
	"stevearc/oil.nvim",
	opts = {
		default_file_explorer = true,
		view_options = { show_hidden = true },
		keymaps = {
			["<C-h>"] = false,
			["<C-l>"] = false,
		},
	},
	lazy = false,
	-- stylua: ignore
	keys = {
		{ "<leader>e", function() require("oil").toggle_float() end, desc = "Explorer (float)" },
	},
}
