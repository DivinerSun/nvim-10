vim.opt.background = "dark"

require("catppuccin").setup({
	flavour = "mocha",
	background = {
		light = "latte",
		dark = "mocha",
	},
	transparent_background = true,
	term_colors = true,
	dim_inactive = {
		enabled = false,
	},
	styles = {
		comments = { "italic" },
		conditionals = { "italic" },
	},
	integrations = {
		native_lsp = {
			enabled = true,
			virtual_text = {
				errors = { "italic" },
				hints = { "italic" },
				warnings = { "italic" },
				information = { "italic" },
				ok = { "italic" },
			},
			underlines = {
				errors = { "underline" },
				hints = { "underline" },
				warnings = { "underline" },
				information = { "underline" },
				ok = { "underline" },
			},
		},
		treesitter = true,
		which_key = true,
		gitsigns = true,
		mason = true,
		fzf = true,
	},
})

vim.cmd.colorscheme("catppuccin")
