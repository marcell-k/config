return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {},
	keys = function()
		local harpoon = require("harpoon")

		return {
			{
				"<leader>ha",
				function()
					harpoon:list():add()
				end,
				desc = "Harpoon Add File",
			},
			{
				"<leader>hh",
				function()
					harpoon.ui:toggle_quick_menu(harpoon:list())
				end,
				desc = "Harpoon Quick Menu",
			},
			{
				"<C-1>",
				function()
					harpoon:list():select(1)
				end,
				desc = "Harpoon to File 1",
			},
			{
				"<C-2>",
				function()
					harpoon:list():select(2)
				end,
				desc = "Harpoon to File 2",
			},
			{
				"<C-3>",
				function()
					harpoon:list():select(3)
				end,
				desc = "Harpoon to File 3",
			},
			{
				"<C-4>",
				function()
					harpoon:list():select(4)
				end,
				desc = "Harpoon to File 4",
			},
		}
	end,
}
