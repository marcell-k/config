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
	dependencies = { { "nvim-mini/mini.icons", opts = {} } },
	lazy = false,
	-- stylua: ignore
	keys = {
		-- { "<leader>e", "<cmd>Oil<cr>", desc = "File Explorer" },
		{ "<leader>e", function() require("oil").toggle_float() end, desc = "Explorer (float)" },
	},
}
