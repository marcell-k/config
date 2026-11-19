--- LSP ---
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local o = function(d)
			return { buffer = ev.buf, desc = d }
		end
		vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, o("Rename"))
		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, o("Code action"))

		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client and client:supports_method("textDocument/inlayHint") then
			vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
		end
	end,
})

vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	once = true,
	callback = function()
		local orig = vim.lsp.handlers["textDocument/signatureHelp"]
		if not orig then
			return
		end
		vim.lsp.handlers["textDocument/signatureHelp"] = function(err, result, ctx, config)
			if result and result.signatures and #result.signatures > 1 then
				local active = (result.activeSignature or 0) + 1
				result.signatures = { result.signatures[active] }
				result.activeSignature = 0
			end
			orig(err, result, ctx, config)
		end
	end,
})
