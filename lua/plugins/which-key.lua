return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			icons = { group = "" },
			spec = {
				{ "<leader>a", group = "AICode", icon = " " },
				{ "<leader>b", group = "Buffer", icon = " " },
				{ "<leader>c", group = "Codes", icon = " " },
				{ "<leader>f", group = "Find", icon = " " },
				{ "<leader>g", group = "Git", icon = " " },
				{ "<leader>q", group = "Session", icon = " " },
				{ "<leader>s", group = "LSP", icon = "󰃡 " },
				{ "<leader>u", group = "UI", icon = " " },
				{ "<leader>p", group = "Preview/Paste", icon = " " },
				{ "<leader>t", group = "Trouble", icon = "󱏛 " },
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
				-- function()
				-- 	local word = vim.fn.expand("<cword>")
				-- 	local replace_cmd = string.format(":%%s/\\<%s\\>/%s/gI", word, word)
				-- 	vim.api.nvim_feedkeys(
				-- 		vim.api.nvim_replace_termcodes(replace_cmd .. "<Left><Left><Left>", true, false, true),
				-- 		"n",
				-- 		false
				-- 	)
				-- end,
				desc = "Rename in current buffer only",
			},
		},
	},
}
