return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			style = "strom", -- moon | storm | night | day
			light_style = "day",
			transparent = true,
			terminal_colors = true,
			styles = {
				comments = { blod = true },
				keywords = { italic = true, blod = true },
				functions = { italic = true },
				variables = {},
				sidebars = "transparent",
				floats = "transparent",
			},
			day_brightness = 0.3,
			dim_inactive = false,
			lualine_bold = false,
			on_colors = function(C)
				C.comment = "#FF81D0"
				C.fg_gutter = "#813c85"

				return {
					Comment = { fg = C.pink },

					BlinkCmpKindText = { fg = C.blue1 }, -- 蓝色
					BlinkCmpKindMethod = { fg = C.magenta2 }, -- 紫色
					BlinkCmpKindFunction = { fg = C.blue }, -- 蓝色
					BlinkCmpKindConstructor = { fg = C.orange }, -- 橙色
					BlinkCmpKindField = { fg = C.green }, -- 绿色
					BlinkCmpKindVariable = { fg = C.purple }, -- 紫色
					BlinkCmpKindClass = { fg = C.yellow }, -- 黄色
					BlinkCmpKindInterface = { fg = C.cyan }, -- 青色
					BlinkCmpKindModule = { fg = C.blue }, -- 蓝色
					BlinkCmpKindProperty = { fg = C.green1 }, -- 浅绿
					BlinkCmpKindUnit = { fg = C.green2 }, -- 深绿
					BlinkCmpKindValue = { fg = C.orange }, -- 橙色
					BlinkCmpKindEnum = { fg = C.green }, -- 绿色
					BlinkCmpKindKeyword = { fg = C.red }, -- 红色
					BlinkCmpKindSnippet = { fg = C.magenta }, -- 洋红
					BlinkCmpKindColor = { fg = C.red }, -- 红色
					BlinkCmpKindFile = { fg = C.blue }, -- 蓝色
					BlinkCmpKindReference = { fg = C.red1 }, -- 浅红
					BlinkCmpKindFolder = { fg = C.blue }, -- 蓝色
					BlinkCmpKindEnumMember = { fg = C.green }, -- 绿色
					BlinkCmpKindConstant = { fg = C.orange }, -- 橙色
					BlinkCmpKindStruct = { fg = C.cyan }, -- 青色
					BlinkCmpKindEvent = { fg = C.magenta }, -- 洋红
					BlinkCmpKindOperator = { fg = C.cyan }, -- 青色
					BlinkCmpKindTypeParameter = { fg = C.teal }, -- 青绿

					-- ⭐ Blink.cmp 来源颜色配置
					BlinkCmpSourceLsp = { fg = C.cyan }, -- LSP - 蓝色
					BlinkCmpSourceBuffer = { fg = C.green }, -- Buffer - 绿色
					BlinkCmpSourcePath = { fg = C.yellow }, -- Path - 黄色
					BlinkCmpSourceSnippets = { fg = C.teal }, -- Snippets - 洋红
					BlinkCmpSourceLazydev = { fg = C.blue }, -- LazyDev - 青色

					CmpItemMenu = { fg = C.pink, bg = C.None },
					CmpItemKindSnippet = { fg = C.base, bg = C.mauve },
					CmpItemKindKeyword = { fg = C.base, bg = C.red },
					CmpItemKindText = { fg = C.base, bg = C.lavender },
					CmpItemKindMethod = { fg = C.base, bg = C.blue },
					CmpItemKindConstructor = { fg = C.base, bg = C.blue },
					CmpItemKindFunction = { fg = C.base, bg = C.blue },
					CmpItemKindFolder = { fg = C.base, bg = C.blue },
					CmpItemKindModule = { fg = C.base, bg = C.blue },
					CmpItemKindConstant = { fg = C.base, bg = C.peach },
					CmpItemKindField = { fg = C.base, bg = C.green },
					CmpItemKindProperty = { fg = C.base, bg = C.green },
					CmpItemKindEnum = { fg = C.base, bg = C.green },
					CmpItemKindUnit = { fg = C.base, bg = C.green },
					CmpItemKindClass = { fg = C.base, bg = C.yellow },
					CmpItemKindVariable = { fg = C.base, bg = C.flamingo },
					CmpItemKindFile = { fg = C.base, bg = C.blue },
					CmpItemKindInterface = { fg = C.base, bg = C.yellow },
					CmpItemKindColor = { fg = C.base, bg = C.red },
					CmpItemKindReference = { fg = C.base, bg = C.red },
					CmpItemKindEnumMember = { fg = C.base, bg = C.red },
					CmpItemKindStruct = { fg = C.base, bg = C.blue },
					CmpItemKindValue = { fg = C.base, bg = C.peach },
					CmpItemKindEvent = { fg = C.base, bg = C.blue },
					CmpItemKindOperator = { fg = C.base, bg = C.blue },
					CmpItemKindTypeParameter = { fg = C.base, bg = C.blue },
					CmpItemKindCopilot = { fg = C.base, bg = C.teal },
					CmpItemKindCodeium = { fg = C.base, bg = C.teal },
				}
			end,
			on_highlights = function(highlights, C)
				-- ⭐ 选中项高亮（明显的背景色）
				highlights.BlinkCmpMenuSelection = {
					bg = C.comment, -- 蓝色背景
					fg = C.bg, -- 深色前景（文字）
					bold = true, -- 加粗
				}
				highlights.Visual = { bg = "#3e4a7a", fg = "#ffffff" }
				highlights.VisualNOS = { bg = "#3e4a7a" }
			end,
			cache = true,
			plugins = {
				all = package.loaded.lazy == nil,
				auto = true,
				telescope = true,
			},
		},
	},
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
					-- text = "#acb8f4",
				},
			},
			custom_highlights = function(C)
				return {
					Comment = { fg = "#FF81D0" },
					Gutter = { fg = "#813c85" },
					TabLineSel = { bg = C.pink },
					CmpBorder = { fg = C.surface2 },
					Pmenu = { bg = C.none },

					-- ⭐ Blink.cmp 高亮组配置
					-- 基础高亮
					BlinkCmpLabel = { fg = C.fg },
					BlinkCmpLabelDeprecated = { fg = C.comment, strikethrough = true },
					BlinkCmpLabelDescription = { fg = C.comment },
					-- ⭐ 选中项高亮（明显的背景色）
					BlinkCmpMenuSelection = {
						bg = C.comment, -- 蓝色背景
						fg = C.bg, -- 深色前景（文字）
						bold = true, -- 加粗
					},
					Visual = { bg = "#3e4a7a", fg = "#ffffff" },
					VisualNOS = { bg = "#3e4a7a" },

					-- 不同类型的颜色配置（格式：BlinkCmpKind + 类型名
					BlinkCmpKindText = { fg = C.blue1 }, -- 蓝色
					BlinkCmpKindMethod = { fg = C.magenta2 }, -- 紫色
					BlinkCmpKindFunction = { fg = C.blue }, -- 蓝色
					BlinkCmpKindConstructor = { fg = C.orange }, -- 橙色
					BlinkCmpKindField = { fg = C.green }, -- 绿色
					BlinkCmpKindVariable = { fg = C.purple }, -- 紫色
					BlinkCmpKindClass = { fg = C.yellow }, -- 黄色
					BlinkCmpKindInterface = { fg = C.cyan }, -- 青色
					BlinkCmpKindModule = { fg = C.blue }, -- 蓝色
					BlinkCmpKindProperty = { fg = C.green1 }, -- 浅绿
					BlinkCmpKindUnit = { fg = C.green2 }, -- 深绿
					BlinkCmpKindValue = { fg = C.orange }, -- 橙色
					BlinkCmpKindEnum = { fg = C.green }, -- 绿色
					BlinkCmpKindKeyword = { fg = C.red }, -- 红色
					BlinkCmpKindSnippet = { fg = C.magenta }, -- 洋红
					BlinkCmpKindColor = { fg = C.red }, -- 红色
					BlinkCmpKindFile = { fg = C.blue }, -- 蓝色
					BlinkCmpKindReference = { fg = C.red1 }, -- 浅红
					BlinkCmpKindFolder = { fg = C.blue }, -- 蓝色
					BlinkCmpKindEnumMember = { fg = C.green }, -- 绿色
					BlinkCmpKindConstant = { fg = C.orange }, -- 橙色
					BlinkCmpKindStruct = { fg = C.cyan }, -- 青色
					BlinkCmpKindEvent = { fg = C.magenta }, -- 洋红
					BlinkCmpKindOperator = { fg = C.cyan }, -- 青色
					BlinkCmpKindTypeParameter = { fg = C.teal }, -- 青绿）

					-- ⭐ Blink.cmp 来源颜色配置
					BlinkCmpSourceLsp = { fg = C.blue, italic = true }, -- LSP - 蓝色
					BlinkCmpSourceBuffer = { fg = C.green, italic = true }, -- Buffer - 绿色
					BlinkCmpSourcePath = { fg = C.yellow, italic = true }, -- Path - 黄色
					BlinkCmpSourceSnippet = { fg = C.magenta, italic = true }, -- Snippets - 洋红
					BlinkCmpSourceLazydev = { fg = C.teal, italic = true }, -- LazyDev - 青色
					BlinkCmpSourceRipgrep = { fg = C.teal, italic = true }, -- Ripgrep - 青色
					BlinkCmpSourceEmoji = { fg = C.orange, italic = true }, -- Emoji - 青色
				}
			end,
			highlight_overrides = {
				all = function(cp)
					local clear = {}
					local transparent_background = true
					return {
						-- For base configs
						NormalFloat = { fg = cp.text, bg = transparent_background and cp.none or cp.mantle },
						FloatBorder = {
							fg = transparent_background and cp.blue or cp.mantle,
							bg = transparent_background and cp.none or cp.mantle,
						},
						CursorLineNr = { fg = cp.green },

						-- For native lsp configs
						DiagnosticVirtualTextError = { bg = cp.none },
						DiagnosticVirtualTextWarn = { bg = cp.none },
						DiagnosticVirtualTextInfo = { bg = cp.none },
						DiagnosticVirtualTextHint = { bg = cp.none },
						LspInfoBorder = { link = "FloatBorder" },

						-- For mason.nvim
						MasonNormal = { link = "NormalFloat" },

						-- For indent-blankline
						IblIndent = { fg = cp.surface0 },
						IblScope = { fg = cp.surface2, style = { "bold" } },

						-- For nvim-cmp and wilder.nvim
						Pmenu = { fg = cp.overlay2, bg = transparent_background and cp.none or cp.base },
						PmenuBorder = { fg = cp.surface1, bg = transparent_background and cp.none or cp.base },
						PmenuSel = { bg = cp.green, fg = cp.base },
						CmpItemAbbr = { fg = cp.overlay2 },
						CmpItemAbbrMatch = { fg = cp.blue, style = { "bold" } },
						CmpDoc = { link = "NormalFloat" },
						CmpDocBorder = {
							fg = transparent_background and cp.surface1 or cp.mantle,
							bg = transparent_background and cp.none or cp.mantle,
						},

						-- For fidget
						FidgetTask = { bg = cp.none, fg = cp.surface2 },
						FidgetTitle = { fg = cp.blue, style = { "bold" } },

						-- For nvim-notify
						NotifyBackground = { bg = cp.base },

						-- For nvim-tree
						NvimTreeRootFolder = { fg = cp.pink },
						NvimTreeIndentMarker = { fg = cp.surface2 },

						-- For trouble.nvim
						TroubleNormal = { bg = transparent_background and cp.none or cp.base },
						TroubleNormalNC = { bg = transparent_background and cp.none or cp.base },

						-- For telescope.nvim
						TelescopeMatching = { fg = cp.lavender },
						TelescopeResultsDiffAdd = { fg = cp.green },
						TelescopeResultsDiffChange = { fg = cp.yellow },
						TelescopeResultsDiffDelete = { fg = cp.red },

						-- For glance.nvim
						GlanceWinBarFilename = { fg = cp.subtext1, style = { "bold" } },
						GlanceWinBarFilepath = { fg = cp.subtext0, style = { "italic" } },
						GlanceWinBarTitle = { fg = cp.teal, style = { "bold" } },
						GlanceListCount = { fg = cp.lavender },
						GlanceListFilepath = { link = "Comment" },
						GlanceListFilename = { fg = cp.blue },
						GlanceListMatch = { fg = cp.lavender, style = { "bold" } },
						GlanceFoldIcon = { fg = cp.green },

						-- For nvim-treehopper
						TSNodeKey = {
							fg = cp.peach,
							bg = transparent_background and cp.none or cp.base,
							style = { "bold", "underline" },
						},

						-- For treesitter
						["@keyword.return"] = { fg = cp.pink, style = clear },
						["@error.c"] = { fg = cp.none, style = clear },
						["@error.cpp"] = { fg = cp.none, style = clear },
					}
				end,
			},
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
