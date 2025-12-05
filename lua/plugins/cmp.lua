return {
	{
		"saghen/blink.compat",
		version = "2.*",
		lazy = true,
		opts = {},
	},
	{
		"saghen/blink.pairs",
		version = "*",
		dependencies = "saghen/blink.download",
		opts = {
			mappings = {
				enabled = true,
				cmdline = true,
				disabled_filetypes = {},
				pairs = {},
			},
			highlights = {
				enabled = true,
				cmdline = true,
				groups = {
					"BlinkPairsOrange",
					"BlinkPairsPurple",
					"BlinkPairsBlue",
				},
				unmatched_group = "BlinkPairsUnmatched",
				matchparen = {
					enabled = true,
					cmdline = false,
					include_surrounding = false,
					group = "BlinkPairsMatchParen",
					priority = 250,
				},
			},
			debug = false,
		},
	},
	{
		"kristijanhusak/vim-dadbod-ui",
		dependencies = {
			{ "tpope/vim-dadbod", lazy = true },
			{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
		},
		cmd = {
			"DBUI",
			"DBUIToggle",
			"DBUIAddConnection",
			"DBUIFindBuffer",
		},
		init = function()
			vim.g.db_ui_use_nerd_fonts = 1
		end,
	},
	{
		"saghen/blink.cmp",
		dependencies = {
			"rafamadriz/friendly-snippets",
			{ "dmitmel/cmp-digraphs" },
			{
				"mikavilpas/blink-ripgrep.nvim",
				version = "*",
			},
			"moyiz/blink-emoji.nvim",
			"MahanRahmati/blink-nerdfont.nvim",
			"jdrupal-dev/css-vars.nvim",
			"Kaiser-Yang/blink-cmp-avante",
			{
				"roobert/tailwindcss-colorizer-cmp.nvim",
				dependencies = {
					-- 颜色插件
					{
						"catgoose/nvim-colorizer.lua",
						event = "BufReadPre",
						config = function()
							require("colorizer").setup({
								filetypes = { "*" },
								buftypes = {},
								user_commands = true,
								lazy_load = false,
								user_default_options = {
									names = true,
									names_opts = {
										lowercase = true,
										camelcase = true,
										uppercase = true,
										strip_digits = false,
									},
									names_custom = false,
									RGB = true,
									RGBA = true,
									RRGGBB = true,
									RRGGBBAA = true,
									AARRGGBB = true,
									rgb_fn = true,
									hsl_fn = false,
									oklch_fn = false,
									css = true,
									css_fn = true,
									tailwind = true, -- boolean|'normal'|'lsp'|'both'
									tailwind_opts = {
										update_names = true,
									},
									sass = { enable = true, parsers = { "css" } },
									xterm = true,
									mode = "background", -- 'background'|'foreground'|'virtualtext'
									virtualtext = "■",
									virtualtext_inline = true, -- boolean|'before'|'after'
									virtualtext_mode = "foreground", -- 'background'|'foreground'
									always_update = false,
									hooks = {
										disable_line_highlight = false,
									},
								},
							})
						end,
					},
				},
				config = function()
					require("tailwindcss-colorizer-cmp").setup({
						color_square_width = 2,
					})
				end,
			},
		},
		version = "1.*",
		opts = function()
			-- ⭐ 引入 icons 模块
			local icons = require("utils.icons")

			return {
				keymap = {
					preset = "default",
					["<C-j>"] = {
						function(cmp)
							return cmp.select_next({ count = 5 })
						end,
						"fallback",
					},
					["<C-k>"] = {
						function(cmp)
							return cmp.select_prev({ count = 5 })
						end,
						"fallback",
					},
					["<Tab>"] = { "select_next", "fallback" },
					["<S-Tab>"] = { "select_prev", "fallback" },
					["<CR>"] = { "accept", "fallback" },
				},

				appearance = {
					nerd_font_variant = "mono",

					-- ⭐ 自定义图标
					kind_icons = icons.kind_icons_animal,
				},
				completion = {
					documentation = { auto_show = true },
					menu = {
						auto_show = true, -- 自动显示菜单
						border = "rounded",
						winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
						-- ⭐ 自定义菜单绘制
						draw = {
							columns = {
								{ "kind_icon", gap = 1 }, -- 图标 + 类型
								{ "label", "label_description", gap = 1 }, -- 提示内容 + 描述
								{ "kind", "source_name" }, -- 显示来源（LSP、Buffer等）
							},
							components = {
								-- 自定义 kind 显示（类型文本）
								kind = {
									text = function(ctx)
										return ctx.kind
									end,
									highlight = function(ctx)
										return "BlinkCmpKind" .. ctx.kind
									end,
								},
								-- 自定义 kind_icon 显示（图标）
								kind_icon = {
									text = function(ctx)
										return ctx.kind_icon .. " "
									end,
									highlight = function(ctx)
										return "BlinkCmpKind" .. ctx.kind
									end,
								},
								-- ⭐ label 跟随 kind 颜色
								label = {
									text = function(ctx)
										return ctx.label
									end,
									highlight = function(ctx)
										if ctx.deprecated then
											return "BlinkCmpLabelDeprecated"
										end
										-- ⭐ 根据类型使用不同颜色
										return "BlinkCmpKind" .. ctx.kind
									end,
								},
								label_description = {
									text = function(ctx)
										return ctx.label_description or ""
									end,
									highlight = function(ctx)
										-- ⭐ 描述也跟随 kind 颜色，但更淡一些
										return "BlinkCmpKindDescription" .. ctx.kind
									end,
								},

								-- ⭐ 自定义 source_name 组件
								source_name = {
									text = function(ctx)
										-- 自定义来源显示文本
										local source_map = {
											LSP = "[󰬓]",
											Buffer = "[]",
											Path = "[󰴠]",
											Snippets = "[󰬚]",
											Lazydev = "[󰵮]",
											Ripgrep = "[󰬙]",
											Emoji = "[󰞅]",
											NerdFonts = "[]",
											CssVars = "[]",
											Avante = "[󰬈]",
										}
										return source_map[ctx.source_name] or "[" .. ctx.source_name .. "]"
									end,
									highlight = function(ctx)
										-- 根据不同来源使用不同高亮
										return "BlinkCmpSource" .. ctx.source_name:gsub("^%l", string.upper)
									end,
								},
							},
						},
					},
					list = {
						selection = { preselect = true, auto_insert = true },
					},
				},
				signature = { enabled = true },
				sources = {
					default = {
						"lazydev",
						"lsp",
						"path",
						"snippets",
						"buffer",
						"digraphs",
						"ripgrep",
						"emoji",
						"nerdfont",
						"avante",
					},
					per_filetype = {
						lua = { inherit_defaults = true, "lazydev" },
						sql = { "snippets", "dadbod", "buffer" },
					},
					providers = {
						dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
						lazydev = {
							name = "LazyDev",
							module = "lazydev.integrations.blink",
							score_offset = 100,
						},
						lsp = {
							name = "LSP",
							module = "blink.cmp.sources.lsp",
							score_offset = 90,
						},
						path = {
							name = "Path",
							module = "blink.cmp.sources.path",
							score_offset = 50,
						},
						snippets = {
							name = "Snippets",
							module = "blink.cmp.sources.snippets",
							score_offset = 80,
						},
						buffer = {
							name = "Buffer",
							module = "blink.cmp.sources.buffer",
							score_offset = 60,
						},
						avante = {
							module = "blink-cmp-avante",
							name = "Avante",
							score_offset = 80,
							opts = {},
						},
						digraphs = {
							name = "digraphs",
							module = "blink.compat.source",
							score_offset = -3,
							opts = {
								cache_digraphs_on_start = true,
							},
						},
						ripgrep = {
							module = "blink-ripgrep",
							name = "Ripgrep",
							score_offset = 10,
							opts = {},
						},
						emoji = {
							module = "blink-emoji",
							name = "Emoji",
							score_offset = 15,
							opts = {
								insert = true,
								trigger = function()
									return { ":" }
								end,
							},
						},
						nerdfont = {
							module = "blink-nerdfont",
							name = "NerdFonts",
							score_offset = 15,
							opts = { insert = true },
						},
						css_vars = {
							name = "CssVars",
							module = "css-vars.blink",
							score_offset = 5,
							opts = {
								search_extensions = {
									".js",
									".ts",
									".jsx",
									".tsx",
									".html",
									".css",
									".less",
									".scss",
									".vue",
								},
							},
						},
					},
				},
				fuzzy = { implementation = "prefer_rust_with_warning" },
			}
		end,

		opts_extend = { "sources.default" },
	},
	{
		"Exafunction/windsurf.vim",
		event = "BufEnter",
		config = function()
			vim.keymap.set("i", "<C-g>", function()
				return vim.fn["codeium#Accept"]()
			end, { expr = true, silent = true, desc = "Codeium Accept" })
			vim.keymap.set("i", "<c-x>", function()
				return vim.fn["codeium#Clear"]()
			end, { expr = true, silent = true, desc = "Codeium Clear" })
		end,
	},
	{
		"olrtg/nvim-emmet",
		config = function()
			vim.keymap.set({ "n", "v" }, "<leader>xe", require("nvim-emmet").wrap_with_abbreviation)
		end,
	},
}
