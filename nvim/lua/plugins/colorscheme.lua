return {
	{
		"rebelot/kanagawa.nvim",
		priority = 1000,
		lazy = false,

		opts = {
			theme = "dragon", -- 'wave', 'dragon', 'lotus'
			terminalColors = true,
			undercurl = true,
			commentStyle = { italic = true },
			keywordStyle = { italic = false },
			statementStyle = { bold = true },
			transparent = false,
			dimInactive = false,

			colors = {
				theme = {
					all = {
						ui = {
							bg_gutter = "none",
						},
					},
				},
			},

			overrides = function(colors)
				local theme = colors.theme
				local c = require("kanagawa.lib.color")

				local makeDiagnosticColor = function(color)
					return {
						fg = color,
						bg = c(color):blend(theme.ui.bg, 0.95):to_hex(),
					}
				end

				return {
					-- Floating windows
					NormalFloat = { bg = "none" },
					FloatBorder = { bg = "none" },
					FloatTitle = { bg = "none" },
					NormalDark = {
						fg = theme.ui.fg_dim,
						bg = theme.ui.bg_m3,
					},
					LazyNormal = {
						bg = theme.ui.bg_m3,
						fg = theme.ui.fg_dim,
					},
					MasonNormal = {
						bg = theme.ui.bg_m3,
						fg = theme.ui.fg_dim,
					},
					CursorLine = {
						bg = c(theme.ui.bg_p2):blend(theme.ui.bg, 0.5):to_hex(),
					},

					-- Completion popup
					Pmenu = {
						fg = theme.ui.shade0,
						bg = theme.ui.bg_p1,
					},
					PmenuSel = {
						fg = "NONE",
						bg = theme.ui.bg_p2,
					},
					PmenuSbar = { bg = theme.ui.bg_m1 },
					PmenuThumb = { bg = theme.ui.bg_p2 },

					-- Diagnostic virtual text
					DiagnosticVirtualTextHint = makeDiagnosticColor(theme.diag.hint),
					DiagnosticVirtualTextInfo = makeDiagnosticColor(theme.diag.info),
					DiagnosticVirtualTextWarn = makeDiagnosticColor(theme.diag.warning),
					DiagnosticVirtualTextError = makeDiagnosticColor(theme.diag.error),

					-- Rust unsafe keyword
					["@lsp.typemod.keyword.unsafe.rust"] = {
						fg = require("palette").error,
						bold = true,
						italic = false,
					},
				}
			end,
		},

		config = function(_, opts)
			require("kanagawa").setup(opts)
			vim.cmd.colorscheme("kanagawa-dragon")
		end,
	},
}
