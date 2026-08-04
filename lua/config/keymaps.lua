local map = vim.keymap.set

-- Buffer navigation
map("n", "<C-n>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<C-b>", "<cmd>bprev<cr>", { desc = "Prev Buffer" })

-- Close buffer without closing the split
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
map({ "n", "v", "o" }, "<leader>j", "`", { desc = "Jump to mark (exact line & col)" })

-- Vertical window split
map("n", "<leader>í", "<cmd>vsplit<cr>", { desc = "Vertical Split" })

-- Search stays centered
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Remap '4' to go to the end of the line (replacing '$')
map({ "n", "v", "o" }, "4", "$", { desc = "Go to end of line / operator motion" })

--- Code Action ---
map({ "n", "v" }, "<leader>vca", function()
    vim.lsp.buf.code_action()
end)

-- Insert semicolon with Ctrl+.
map("i", "<C-.>", ";", { desc = "Insert Semicolon" })

local term_buf = nil

map("n", "<leader>tt", function()
    -- Step 1: If the terminal buffer exists and is currently visible, hide it
    if term_buf and vim.api.nvim_buf_is_valid(term_buf) then
        local term_win = vim.fn.bufwinid(term_buf)
        if term_win ~= -1 then
            vim.api.nvim_win_close(term_win, false)
            return
        end
    end

    -- Step 2: Open a clean window split at the bottom
    vim.cmd("botright split | resize 20")
    local new_win = vim.api.nvim_get_current_win()

    -- Step 3: If the background terminal buffer is still alive, reload it here
    if term_buf and vim.api.nvim_buf_is_valid(term_buf) then
        vim.cmd("buffer " .. term_buf)
    else
        -- Step 4: Otherwise, create a fresh terminal and capture its unique ID.
        -- Flag this as "our" terminal so the TermOpen autocmd knows it's safe
        -- to auto-source the venv (as opposed to e.g. a lazygit terminal).
        vim.g._autosource_venv_pending = true
        vim.cmd("terminal")
        term_buf = vim.api.nvim_get_current_buf()
    end

    -- Step 5: Force Neovim to focus on this window and drop into insert mode
    vim.api.nvim_set_current_win(new_win)
    vim.cmd("startinsert")
end, { desc = "Toggle Full-Height Terminal" })

map("t", "<leader>tt", function()
    local current_buf = vim.api.nvim_get_current_buf()
    local term_win = vim.fn.bufwinid(current_buf)
    if term_win ~= -1 then
        vim.cmd("stopinsert")
        vim.api.nvim_win_close(term_win, false)
    end
end, { desc = "Hide Terminal From Inside Insert Mode" })

-- Disable arrow keys
for _, mode in ipairs({ "n", "i", "v", "x" }) do
    for _, arrow in ipairs({ "<Up>", "<Down>", "<Left>", "<Right>" }) do
        map(mode, arrow, "<Nop>", { desc = "Disabled - Use hjkl!" })
    end
end
