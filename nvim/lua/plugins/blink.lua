return {
	{
		"saghen/blink.cmp",
		opts = {
			keymap = {
				preset = "default",
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
					-- Kinds: 2=Method 3=Function 4=Constructor 7=Class
					local callable = { [2] = true, [3] = true, [4] = true, [7] = true }
					for _, item in ipairs(items) do
						if callable[item.kind] then
							local label = item.label or ""
							-- skip if already has parens
							if not label:find("%(") then
								item.insertTextFormat = 2 -- snippet
								item.insertText = label .. "($1)"
							end
						end
					end
					return items
				end,
			},
		},
	},
}
