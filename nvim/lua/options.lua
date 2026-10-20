vim.g.python3_host_prog = vim.fn.expand("~/.local/share/nvim-venv/bin/python")
vim.opt.selection = "inclusive"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.wrap = true

vim.opt.textwidth = 100
vim.opt.colorcolumn = ""

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

-- vim.opt.formatoptions:append("cq")
vim.opt.isfname:append("@-@")

vim.opt.scrolloff = 12
vim.opt.sidescrolloff = 12
vim.opt.signcolumn = "yes"

vim.opt.updatetime = 200

vim.opt.clipboard = "unnamedplus"

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

vim.opt.splitright = true -- vsplit opens to the right (natural)
vim.opt.splitbelow = true -- split opens below (natural)
vim.opt.cursorline = true -- highlight current line (pairs well with kanagawa-dragon)

--- when enable luline remove this line
vim.opt.laststatus = 0
