return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		init = function()
			-- 设置主题
			vim.cmd.colorscheme("catppuccin")
		end,
		opts = {
			transparent_background = true,
			float = {
				transparent = true,
			},
			styles = {
				comments = { "italic", "bold" },
				conditionals = { "italic" },
				loops = {},
				functions = { "italic", "bold" },
				keywords = { "italic", "bold" },
				strings = { "bold" },
				variables = { "bold" },
				numbers = { "bold" },
				booleans = { "bold" },
				properties = { "bold" },
				types = { "bold" },
				operators = { "bold" },
			},
			lsp_styles = {
				underlines = {
					errors = { "undercurl" },
					hints = { "undercurl" },
					warnings = { "undercurl" },
					information = { "undercurl" },
				},
			},
			integrations = {
				aerial = true,
				alpha = true,
				cmp = true,
				dashboard = true,
				flash = true,
				fzf = true,
				grug_far = true,
				gitsigns = true,
				headlines = true,
				illuminate = true,
				indent_blankline = { enabled = true },
				leap = true,
				lsp_trouble = true,
				mason = true,
				mini = true,
				navic = { enabled = true, custom_bg = "lualine" },
				neotest = true,
				neotree = true,
				noice = true,
				notify = true,
				snacks = true,
				telescope = true,
				treesitter_context = true,
				which_key = true,
			},
			-- 自定义颜色高亮值
			custom_highlights = function(C)
				C.comment = "#FF81D0"
				C.fg_gutter = "#813c85"

				return {
					Comment = { fg = C.comment },
					Pmenu = { bg = C.none },
				}
			end,
		},
	},
}
