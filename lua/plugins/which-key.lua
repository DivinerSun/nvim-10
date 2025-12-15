return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts_extend = { "spec" },
		opts = {
			preset = "helix",
			icons = { group = "" },
			spec = {
				{
					mode = { "n", "x" },
					-- { "<leader>a", group = "AICode", icon = " " },
					-- { "<leader>b", group = "Buffer", icon = " " },
					-- { "<leader>c", group = "Codes", icon = " " },
					-- { "<leader>f", group = "Find", icon = " " },
					-- { "<leader>g", group = "Git", icon = " " },
					{ "<leader>q", group = "Session", icon = " " },
					{ "<leader>s", group = "Split", icon = " " },
					-- { "<leader>u", group = "UI", icon = " " },
					-- { "<leader>p", group = "Preview/Paste", icon = " " },
					-- { "<leader>t", group = "Trouble", icon = "󱏛 " },
				},
			},
		},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
			{
				"<leader>r",
				[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
				desc = "Rename in current buffer only",
			},
		},
		config = function(_, opts)
			local wk = require("which-key")
			wk.setup(opts)
		end,
	},
}
