-- 高亮复制
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 200,
		})
	end,
	desc = "Highlight yanked text",
})

-- 保存时删除行尾空格
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function()
		local save = vim.fn.getpos(".")
		vim.cmd([[%s/\s\+$//e]])
		vim.fn.setpos(".", save)
	end,
})
