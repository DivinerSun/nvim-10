return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false, -- 确保插件立即加载
		priority = 1000, -- 优先加载主题
		opts = {
			flavour = "auto", -- latte, frappe, macchiato, mocha
			transparent_background = true, -- 启用透明背景
			background = { -- :h background
				light = "latte",
				dark = "mocha",
			},
			float = {
				transparent = true, -- enable transparent floating windows
				solid = true, -- use solid styling for floating windows, see |winborder|
			},
			show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
			term_colors = true, -- sets terminal colors (e.g. `g:terminal_color_0`)
			dim_inactive = {
				enabled = false, -- dims the background color of inactive window
				shade = "dark",
				percentage = 0.15, -- percentage of the shade to apply to the inactive window
			},
			no_italic = false, -- Force no italic
			no_bold = false, -- Force no bold
			no_underline = false, -- Force no underline
			styles = {
				comments = { "bold" },
				properties = { "bold" },
				functions = { "bold" },
				keywords = { "italic", "bold" },
				operators = { "bold" },
				conditionals = { "italic" },
				loops = { "italic" },
				booleans = { "bold", "italic" },
				numbers = {},
				types = {},
				strings = {},
				variables = {},
			},
			lsp_styles = { -- Handles the style of specific lsp hl groups (see `:h lsp-highlight`).
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
			color_overrides = {
				all = {
					text = "#acb8f4",
				},
			},
			custom_highlights = function(C)
				return {
					Comment = { fg = "#FF81D0" },
					Gutter = { fg = "#813c85" },

					Visual = { bg = "#3e4a7a", fg = "#ffffff" },
					VisualNOS = { bg = "#3e4a7a" },
				}
			end,
			default_integrations = true,
			auto_integrations = false,
			integrations = {
				cmp = true,
				dap = true,
				dap_ui = true,
				diffview = true,
				dropbar = { enabled = true, color_mode = true },
				fidget = true,
				flash = true,
				fzf = true,
				gitsigns = true,
				grug_far = true,
				hop = true,
				indent_blankline = { enabled = true, colored_indent_levels = true },
				lsp_saga = true,
				lsp_trouble = true,
				markdown = true,
				mason = true,
				mini = { enabled = true },
				native_lsp = {
					enabled = true,
					virtual_text = {
						errors = { "italic" },
						hints = { "italic" },
						warnings = { "italic" },
						information = { "italic" },
					},
					underlines = {
						errors = { "underline" },
						hints = { "underline" },
						warnings = { "underline" },
						information = { "underline" },
					},
				},
				notify = true,
				nvimtree = true,
				rainbow_delimiters = true,
				render_markdown = true,
				semantic_tokens = true,
				telescope = { enabled = true, style = "nvchad" },
				treesitter = true,
				treesitter_context = true,
				which_key = true,
			},
		},
		config = function(_, opts)
			require("catppuccin").setup(opts)
		end,
	},
}
