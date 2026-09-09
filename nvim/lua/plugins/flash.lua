return {
	{
		"folke/flash.nvim",
		keys = {
			-- Remove "o" from mode so "ys" works for nvim-surround
			{
				"s",
				mode = { "n", "x" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
		},
	},
}
