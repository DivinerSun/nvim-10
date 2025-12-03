return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {},
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
