local K = vim.lsp.protocol.CompletionItemKind
local callable = { [K.Method] = true, [K.Function] = true, [K.Constructor] = true, [K.Class] = true }
return {
	{
		"saghen/blink.cmp",
		opts = {
			keymap = {
				["<C-j>"] = { "select_next", "fallback" },
				["<C-k>"] = { "select_prev", "fallback" },
				["<CR>"] = { "accept", "fallback" },
			},
			signature = { enabled = false },
			completion = {
				accept = { auto_brackets = { enabled = false } }, -- let transform handle it
				list = {
					selection = { preselect = true, auto_insert = false },
				},
			},
			sources = {
				transform_items = function(_, items)
					for _, item in ipairs(items) do
						local label = item.label or ""
						if callable[item.kind] and not label:find("(", 1, true) then
							item.insertTextFormat = 2 -- snippet
							item.insertText = label .. "($1)"
						end
					end
					return items
				end,
			},
		},
	},
}
