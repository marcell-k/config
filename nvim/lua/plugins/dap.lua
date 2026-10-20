return {
	{
		"mfussenegger/nvim-dap",
		-- stylua: ignore
		keys = {
			{ "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Breakpoint" },
			{ "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
			{ "<leader>di", function() require("dap").step_into() end, desc = "Step into" },
			{ "<leader>do", function() require("dap").step_over() end, desc = "Step over" },
			{ "<leader>dO", function() require("dap").step_out() end, desc = "Step out" },
			{ "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
			{ "<leader>dv", function() require("dap-view").toggle() end, desc = "DAP view" },
		},
	},
	{
		"igorlfs/nvim-dap-view",
		dependencies = { "mfussenegger/nvim-dap" },
		opts = { auto_toggle = true },
	},
	{
		"mfussenegger/nvim-dap-python",
		ft = "python",
		dependencies = { "mfussenegger/nvim-dap" },
		config = function()
			require("dap-python").setup("uv")
		end,
		keys = {
			{
				"<leader>dm",
				function()
					require("dap-python").test_method()
				end,
				ft = "python",
				desc = "Debug test method",
			},
		},
	},
}
