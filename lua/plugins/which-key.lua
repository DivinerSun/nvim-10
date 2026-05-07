return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		preset = "helix",
		icons = { group = "" },
		spec = {
			{
				mode = { "n", "x" },
				-- { "<leader>a", group = "AICode", icon = " " },
				{ "<leader>b", group = " Buffer", icon = " " },
				{ "<leader>c", group = " Codes", icon = " " },
				{ "<leader>f", group = " Find", icon = " " },
				{ "<leader>g", group = " Git", icon = " " },
				{ "<leader>q", group = " Session", icon = " " },
				{ "<leader>u", group = " UI", icon = " " },
				{ "<leader>s", group = " Split", icon = " " },
				{ "<leader>p", group = "Preview/Paste", icon = " " },
				{ "<leader>t", group = "Trouble", icon = "󱏛 " },
			},
		},
	},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Local KeyMaps",
		},
	},
}
