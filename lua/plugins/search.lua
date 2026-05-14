local fzf = require("fzf-lua")

fzf.setup({
	winopts = {
		border = "rounded",
		preview = {
			border = "rounded",
		},
	},
	files = {
		git_icons = true,
		file_icons = true,
	},
	grep = {
		rg_opts = "--column --line-number --no-heading --color=always --smart-case --max-columns=4096",
	},
})

vim.keymap.set("n", "<leader>ff", fzf.files, { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", fzf.live_grep, { desc = "Live grep" })
vim.keymap.set("n", "<leader>/", "<cmd>FzfLua live_grep<CR>", { desc = "Find text" })
vim.keymap.set("n", "<leader>fb", fzf.buffers, { desc = "Find buffers" })
vim.keymap.set("n", "<leader>fh", fzf.help_tags, { desc = "Help tags" })
vim.keymap.set("n", "<leader>fr", fzf.oldfiles, { desc = "Recent files" })
vim.keymap.set("n", "<leader>fc", "<cmd>FzfLua colorschemes<CR>", { desc = "Change ColorScheme" })
