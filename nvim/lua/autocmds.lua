--- LSP ---
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local o = function(d)
			return { buffer = ev.buf, desc = d }
		end
		vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, o("Rename"))
		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, o("Code action"))
	end,
})
