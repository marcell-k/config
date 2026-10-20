return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		local ts = require("nvim-treesitter")
		ts.setup()
		ts.install({
			"bash",
			"diff",
			-- "go",
			"json",
			"markdown",
			"markdown_inline",
			"python",
			"regex",
			"rust",
			"toml",
		})
		vim.api.nvim_create_autocmd("FileType", {
			callback = function(ev)
				if pcall(vim.treesitter.start, ev.buf) then
					vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end
			end,
		})
	end,
}
