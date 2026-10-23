return {
	"saghen/blink.cmp",
	version = "1.*",
	dependencies = { "rafamadriz/friendly-snippets" },
	opts = {
		keymap = {
			preset = "enter",
			["<C-j>"] = { "select_next", "fallback" },
			["<C-k>"] = { "select_prev", "fallback" },
			["<C-y>"] = { "select_and_accept" },
		},

		appearance = { nerd_font_variant = "mono" },

		completion = {
			accept = { auto_brackets = { enabled = true } },
			menu = { draw = { treesitter = { "lsp" } } },
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 200,
				window = { max_width = 80, max_height = 15 },
			},
			list = { selection = { preselect = true, auto_insert = false } },
		},

		signature = { enabled = true, window = { show_documentation = false } },

		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
			providers = {
				lsp = {
					transform_items = function(_, items)
						local function bloated(s)
							return type(s) == "string" and s:find("Overload[", 1, true) ~= nil
						end
						for _, item in ipairs(items) do
							if bloated(item.detail) then
								item.detail = nil
							end
							if item.labelDetails then
								for _, k in ipairs({ "detail", "description" }) do
									if bloated(item.labelDetails[k]) then
										item.labelDetails[k] = nil
									end
								end
							end
						end
						return items
					end,
				},
			},
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
