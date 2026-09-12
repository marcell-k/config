return {
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	event = "VeryLazy",
	opts = {
		signs = false,
		keywords = {
			SAFETY = { color = "safety" },
		},
		highlight = {
			multiline = true,
			before = "",
			keyword = "fg",
			pattern = [[.*<(KEYWORDS)\s*:]],
		},
		colors = {
			error = { "#e46876" }, -- FIX (red)
			warning = { "#c4746e" }, -- WARN (muted red)
			info = { "#7fb4ca" }, -- NOTE (blue)
			hint = { "#7aa89f" }, -- HINT/PERF (cyan)
			default = { "#e6c384" }, -- TODO (yellow)
			test = { "#87a987" }, -- TEST (green)
			safety = { "#938aa9" }, -- SAFETY (magenta)
		},
	},
	config = function(_, opts)
		require("todo-comments").setup(opts)

		local fg_colors = {
			FIX = "#e46876",
			WARN = "#c4746e",
			NOTE = "#7fb4ca",
			HINT = "#7aa89f",
			PERF = "#7aa89f",
			TODO = "#e6c384",
			TEST = "#87a987",
			SAFETY = "#938aa9",
		}

		local function apply_todo_highlights()
			for kw, color in pairs(fg_colors) do
				vim.api.nvim_set_hl(0, "TodoFg" .. kw, { fg = color, bg = "none", bold = true })
				vim.api.nvim_set_hl(0, "TodoBg" .. kw, { fg = color, bg = "none", bold = true })
			end

			vim.api.nvim_set_hl(0, "@comment.error", { fg = fg_colors.FIX, bg = "none", bold = true })
			vim.api.nvim_set_hl(0, "@comment.warning", { fg = fg_colors.WARN, bg = "none", bold = true })
			vim.api.nvim_set_hl(0, "@comment.note", { fg = fg_colors.NOTE, bg = "none", bold = true })
			vim.api.nvim_set_hl(0, "@comment.todo", { fg = fg_colors.TODO, bg = "none", bold = true })
			vim.api.nvim_set_hl(0, "Todo", { fg = fg_colors.TODO, bg = "none", bold = true })
		end

		apply_todo_highlights()
		vim.api.nvim_create_autocmd("ColorScheme", {
			callback = apply_todo_highlights,
			desc = "Reapply todo/comment highlights over colorscheme defaults",
		})
	end,
}
