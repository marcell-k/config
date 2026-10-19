local FALLBACK_PYTHON = vim.fn.expand("~/.local/share/nvim-venv/bin/python")
local MAX_HINT = 40

-- ----- Inlay hints: drop Overload[...], truncate long -----
local function hint_text(h)
	if type(h.label) == "string" then
		return h.label
	end
	local t = {}
	for _, part in ipairs(h.label) do
		t[#t + 1] = part.value
	end
	return table.concat(t)
end

local function inlay_hint_filter(err, result, ctx, config)
	if result then
		local out = {}
		for _, h in ipairs(result) do
			local text = hint_text(h)
			if not text:find("Overload[", 1, true) then
				if vim.fn.strchars(text) > MAX_HINT then
					h.tooltip = h.tooltip or text
					h.label = vim.fn.strcharpart(text, 0, MAX_HINT) .. "…"
				end
				out[#out + 1] = h
			end
		end
		result = out
	end
	return vim.lsp.handlers["textDocument/inlayHint"](err, result, ctx, config)
end

-- ----- Hover: keep first overload, collapse rest -----
local function hover_first_overload(err, result, ctx, config)
	local c = result and result.contents
	local v = type(c) == "table" and c.value or c
	if type(v) == "string" then
		local defs, pos = {}, 1
		while true do
			local s = v:find("\ndef ", pos, true)
			if not s then
				break
			end
			defs[#defs + 1] = s
			pos = s + 1
		end
		if #defs > 1 then
			local fenced = v:match("```%s*$") ~= nil
			local head = v:sub(1, defs[2] - 1):gsub("%s+$", "")
			v = head .. ("\n# … +%d more overloads\n"):format(#defs - 1) .. (fenced and "```" or "")
			result.contents = { kind = "markdown", value = v }
		end
	end
	return vim.lsp.handlers["textDocument/hover"](err, result, ctx, config)
end

-- ----- Signature help: active overload only -----
local function signature_active_only(err, result, ctx, config)
	if result and result.signatures and #result.signatures > 1 then
		local active = (result.activeSignature or 0) + 1
		result.signatures = { result.signatures[active] or result.signatures[1] }
		result.activeSignature = 0
	end
	return vim.lsp.handlers["textDocument/signatureHelp"](err, result, ctx, config)
end

return {
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				pyright = { enabled = false },
				basedpyright = { enabled = false },

				pyrefly = {
					handlers = {
						["textDocument/inlayHint"] = inlay_hint_filter,
						["textDocument/hover"] = hover_first_overload,
						["textDocument/signatureHelp"] = signature_active_only,
					},
					before_init = function(_, config)
						local root = config.root_dir or vim.uv.cwd()
						local candidate = root .. "/.venv/bin/python"
						local python_path = vim.uv.fs_stat(candidate) and candidate or FALLBACK_PYTHON

						config.settings = vim.tbl_deep_extend("force", config.settings or {}, {
							python = { pythonPath = python_path },
						})
					end,
				},

				gopls = {},
				taplo = {
					settings = {
						evenBetterToml = {
							fmt = {
								columnWidth = 100,
								arrayAutoCollapse = true,
								arrayAutoExpand = true,
								arrayTrailingComma = false,
							},
						},
					},
				},
			},
		},
	},
}
