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
