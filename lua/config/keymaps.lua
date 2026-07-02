local map = vim.keymap.set

-- Buffer navigation
map("n", "<tab>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<S-tab>", "<cmd>bprev<cr>", { desc = "Prev Buffer" })

-- Close buffer without closing the split
map("n", "<leader>bd", function()
    local buf = vim.api.nvim_get_current_buf()
    vim.cmd("bprev")
    vim.api.nvim_buf_delete(buf, { force = false })
end, { desc = "Delete Buffer" })

-- Page jump (centered)
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- Window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Window Left" })
map("n", "<C-j>", "<C-w>j", { desc = "Window Down" })
map("n", "<C-k>", "<C-w>k", { desc = "Window Up" })
map("n", "<C-l>", "<C-w>l", { desc = "Window Right" })

-- Move lines (Option+j / Option+k)
map("n", "∆", "<cmd>m .+1<cr>==", { desc = "Move Line Down" })
map("i", "∆", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Line Down" })
map("x", "∆", ":m '>+1<cr>gv=gv", { desc = "Move Selection Down" })
map("n", "Ż", "<cmd>m .-2<cr>==", { desc = "Move Line Up" })
map("i", "Ż", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Line Up" })
map("x", "Ż", ":m '<-2<cr>gv=gv", { desc = "Move Selection Up" })

-- Indent (Option+l / Option+h)
map("n", "•", ">>", { desc = "Indent" })
map("n", "ķ", "<<", { desc = "Unindent" })
map("i", "•", "<C-t>", { desc = "Indent" })
map("i", "ķ", "<C-d>", { desc = "Unindent" })
map("x", "•", ">gv", { desc = "Indent" })
map("x", "ķ", "<gv", { desc = "Unindent" })

-- Remap 'ű' to act as backtick (jump to exact mark position)
map({ "n", "v", "o" }, "ű", "`", { desc = "Jump to mark (exact line & col)" })

-- Vertical window split
map("n", "<leader>í", "<cmd>vsplit<cr>", { desc = "Vertical Split" })

-- Search stays centered
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Remap '4' to go to the end of the line (replacing '$')
map({ "n", "v", "o" }, "4", "$", { desc = "Go to end of line / operator motion" })

-- Escape terminal mode using your Karabiner Esc tap
map("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit Terminal Mode" })

-- Disable arrow keys
for _, mode in ipairs({ "n", "i", "v", "x" }) do
    for _, arrow in ipairs({ "<Up>", "<Down>", "<Left>", "<Right>" }) do
        map(mode, arrow, "<Nop>", { desc = "Disabled - Use hjkl!" })
    end
end
