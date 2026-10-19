return {
	"MeanderingProgrammer/render-markdown.nvim",
	ft = { "markdown" },
	dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.icons" },
	opts = {
		heading = { sign = false },
		code = { sign = false, width = "block", right_pad = 1 },
		checkbox = { enabled = true },
	},
}
