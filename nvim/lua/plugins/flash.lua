return {
	"folke/flash.nvim",
	keys = {
		{ "s", mode = { "n", "x", "o" }, false }, -- drop LazyVim's mapping
		{ "S", mode = { "n", "x", "o" }, false }, -- frees visual S for surround
		{
			"s",
			mode = { "n", "x" },
			function()
				require("flash").jump()
			end,
			desc = "Flash",
		},
	},
}
