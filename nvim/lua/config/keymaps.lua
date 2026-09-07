local map = vim.keymap.set

--- Buffer navigation ---
map("n", "<C-n>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<C-b>", "<cmd>bprev<cr>", { desc = "Prev Buffer" })

--- Close buffer without closing the split ---
map("n", "<leader>bd", function()
	local buf = vim.api.nvim_get_current_buf()
	vim.cmd("bprev")
	local ok = pcall(vim.api.nvim_buf_delete, buf, { force = false })
	if not ok then
		local choice = vim.fn.confirm("Buffer has unsaved changes. Force delete?", "&Yes\n&No", 2)
		if choice == 1 then
			vim.api.nvim_buf_delete(buf, { force = true })
		end
	end
end, { desc = "Delete Buffer" })

--- Page jump (centered) ---
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

--- Window navigation ---
map("n", "<C-h>", "<C-w>h", { desc = "Window Left" })
map("n", "<C-j>", "<C-w>j", { desc = "Window Down" })
map("n", "<C-k>", "<C-w>k", { desc = "Window Up" })
map("n", "<C-l>", "<C-w>l", { desc = "Window Right" })

--- Move lines (Option+j / Option+k) ---
map("n", "∆", "<cmd>m .+1<cr>==", { desc = "Move Line Down" })
map("i", "∆", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Line Down" })
map("x", "∆", ":m '>+1<cr>gv=gv", { desc = "Move Selection Down" })
map("n", "Ż", "<cmd>m .-2<cr>==", { desc = "Move Line Up" })
map("i", "Ż", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Line Up" })
map("x", "Ż", ":m '<-2<cr>gv=gv", { desc = "Move Selection Up" })

--- Indent (Option+l / Option+h) ---
map("n", "•", ">>", { desc = "Indent" })
map("n", "ķ", "<<", { desc = "Unindent" })
map("i", "•", "<C-t>", { desc = "Indent" })
map("i", "ķ", "<C-d>", { desc = "Unindent" })
map("x", "•", ">gv", { desc = "Indent" })
map("x", "ķ", "<gv", { desc = "Unindent" })

--- Jump to exact mark position ---
map({ "n", "v", "o" }, "<leader>j", "`", { desc = "Jump to mark (exact line & col)" })

--- Search stays centered ---
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

--- Remap '4' to go to the end of the line (replacing '$') ---
map({ "n", "v", "o" }, "4", "$", { desc = "Go to end of line / operator motion" })

--- Code Action ---
map({ "n", "v" }, "<leader>ca", function()
	vim.lsp.buf.code_action()
end)

--- Show diagnostic float ---
map("n", "<leader>vd", vim.diagnostic.open_float, { desc = "Show Diagnostic" })

--- Insert semicolon with Ctrl+. ---
map("i", "<C-.>", ";", { desc = "Insert Semicolon" })

--- Disable arrow keys ---
for _, mode in ipairs({ "n", "i", "v", "x" }) do
	for _, arrow in ipairs({ "<Up>", "<Down>", "<Left>", "<Right>" }) do
		map(mode, arrow, "<Nop>", { desc = "Disabled - Use hjkl!" })
	end
end
