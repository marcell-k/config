local palette = {
	error = "#e46876", -- FIX
	warning = "#c4746e", -- WARN
	info = "#7fb4ca", -- NOTE
	hint = "#7aa89f", -- HINT/PERF
	default = "#e6c384", -- TODO
	test = "#87a987", -- TEST
	safety = "#938aa9", -- SAFETY
}

-- keyword -> palette key
local keyword_color = {
	FIX = "error",
	WARN = "warning",
	NOTE = "info",
	HINT = "hint",
	PERF = "hint",
	TODO = "default",
	TEST = "test",
	SAFETY = "safety",
}

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
		colors = vim.tbl_map(function(c)
			return { c }
		end, palette),
	},
	config = function(_, opts)
		require("todo-comments").setup(opts)

		local function apply_todo_highlights()
			local function hl(name, key)
				vim.api.nvim_set_hl(0, name, { fg = palette[key], bg = "none", bold = true })
			end

			for kw, key in pairs(keyword_color) do
				hl("TodoFg" .. kw, key)
				hl("TodoBg" .. kw, key)
			end
			hl("@comment.error", "error")
			hl("@comment.warning", "warning")
			hl("@comment.note", "info")
			hl("@comment.todo", "default")
			hl("Todo", "default")
		end

		apply_todo_highlights()
		vim.api.nvim_create_autocmd("ColorScheme", {
			callback = apply_todo_highlights,
			desc = "Reapply todo/comment highlights over colorscheme defaults",
		})
	end,
}
