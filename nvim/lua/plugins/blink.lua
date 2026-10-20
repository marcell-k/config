return {
	"saghen/blink.cmp",
	dependencies = { "saghen/blink.lib", "rafamadriz/friendly-snippets" },
	build = function()
		require("blink.cmp").build():pwait()
	end,
	opts = {
		keymap = {
			preset = "enter",
			["<C-j>"] = { "select_next", "fallback" },
			["<C-k>"] = { "select_prev", "fallback" },
			["<C-y>"] = { "select_and_accept" },
		},

		appearance = { nerd_font_variant = "mono" },

		completion = {
			accept = { auto_brackets = { enabled = false } },
			menu = { draw = { treesitter = { "lsp" } } },
			documentation = { auto_show = true, auto_show_delay_ms = 200 },
			list = { selection = { preselect = true, auto_insert = false } },
		},

		signature = { enabled = false },

		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},

		cmdline = {
			enabled = true,
			keymap = {
				preset = "cmdline",
				["<Right>"] = false,
				["<Left>"] = false,
			},
			completion = {
				list = { selection = { preselect = false } },
				menu = {
					auto_show = function()
						return vim.fn.getcmdtype() == ":"
					end,
				},
				ghost_text = { enabled = true },
			},
		},
	},
}
