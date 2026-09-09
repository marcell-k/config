return {
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	event = "VeryLazy",
	opts = {
		signs = false,
		highlight = {
			multiline = true,
			before = "",
			keyword = "fg",
			pattern = [[.*<(KEYWORDS)\s*:]],
		},
		colors = {
			error = { "#ff7e64" }, -- FIX
			warning = { "#ff5d62" }, -- WARN
			info = { "#7fb4ca" }, -- NOTE
			hint = { "#e6c384" }, -- PERF/HINT
			default = { "#ffa066" }, -- TODO
			test = { "#87a987" }, -- TEST
		},
	},
	config = function(_, opts)
		require("todo-comments").setup(opts)

		local fg_colors = {
			FIX = "#ff7e64",
			WARN = "#ff5d62",
			NOTE = "#ffa066",
			HINT = "#e6c384",
			PERF = "#e6c384",
			TODO = "#7fb4ca",
			TEST = "#87a987",
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
