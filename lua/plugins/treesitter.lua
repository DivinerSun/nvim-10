local treesitter = require("nvim-treesitter")

local languages = {
	"bash",
	"css",
	"html",
	"javascript",
	"json",
	"lua",
	"markdown",
	"markdown_inline",
	"python",
	"query",
	"regex",
	"rust",
	"scss",
	"toml",
	"tsx",
	"typescript",
	"vim",
	"vimdoc",
	"vue",
	"yaml",
	"prisma",
}

treesitter.setup({
	install_dir = vim.fn.stdpath("data") .. "/site",
})

vim.treesitter.language.register("json", "jsonc")

treesitter.install(languages)

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("user_treesitter", { clear = true }),
	pattern = {
		"bash",
		"css",
		"html",
		"javascript",
		"javascriptreact",
		"json",
		"jsonc",
		"lua",
		"markdown",
		"python",
		"rust",
		"scss",
		"toml",
		"typescript",
		"typescriptreact",
		"vim",
		"vue",
		"yaml",
		"prisma",
	},
	callback = function()
		pcall(vim.treesitter.start)
		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})

require("nvim-ts-autotag").setup({
	opts = {
		enable_close = true, -- 输入 > 后自动补 </tag>
		enable_rename = true, -- 修改标签名时同步改配对标签
		enable_close_on_slash = false, -- 输入 </ 时是否自动补全（按需改为 true）
	},
})
