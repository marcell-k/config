return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			words = { enabled = true, modes = { "n", "c" } },
			picker = { enabled = true },
			lazygit = { enabled = true },
			bigfile = { enabled = true },
		},
		-- stylua: ignore
		keys = {
			-- find
			{ "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
			{ "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
			{ "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
			{ "<leader>fp", function() Snacks.picker.projects() end, desc = "Projects" },
			{ "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent" },
			{ "<leader>,", function() Snacks.picker.buffers() end, desc = "Buffers" },

			-- other
			{ "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
			{ "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },

			-- grep
			{ "<leader>sg", function() Snacks.picker.grep() end, desc = "Grep" },
			{ "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },

			-- lsp
			{ "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
			{ "gD", function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
			{ "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
			{ "gI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
		},
	},
}
