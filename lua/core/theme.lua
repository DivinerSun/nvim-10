require("catppuccin").setup({
	flavour = "auto",
	background = {
		light = "latte",
		dark = "mocha",
	},
	transparent_background = true,
	float = {
		transparent = true,
		solid = true,
	},
	term_colors = true,
	dim_inactive = {
		enabled = false,
	},
	styles = {
		comments = { "italic", "bold" },
		conditionals = { "italic", "bold" },
		loops = { "italic" },
		functions = { "italic", "bold" },
		keywords = { "italic", "bold" },
		strings = { "italic" },
		variables = { "italic" },
		numbers = { "bold" },
		booleans = { "bold" },
		properties = { "italic" },
		types = { "bold" },
		operators = { "bold" },
	},
	custom_highlights = function(C)
		C.comment = "#FF81D0"
		C.fg_gutter = "#813c85"

		return {
			Comment = { fg = C.comment },
			Pmenu = { bg = C.none },
		}
	end,
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
			inlay_hints = {
				background = true,
			},
		},
		neotree = true,
		cmp = true,
		gitsigns = true,
		treesitter = true,
		which_key = true,
		mason = true,
		fzf = true,
		snacks = { enabled = true },
		mini = {
			enabled = true,
		},
	},
})

vim.cmd.colorscheme("catppuccin")
