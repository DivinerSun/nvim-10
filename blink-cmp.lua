return {
	-- windsurf
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
		"saghen/blink.compat",
		event = { "InsertEnter", "CmdlineEnter" },
		version = "2.*",
		lazy = true,
		opts = {},
	},
	{
		"saghen/blink.cmp",
		version = "1.*",
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
			{
				"brenoprata10/nvim-highlight-colors",
				config = function()
					vim.opt.termguicolors = true

					require("nvim-highlight-colors").setup({
						render = "background",
						enable_tailwind = true,
					})
				end,
			},
		},
		opts_extend = {
			"sources.completion.enabled_providers",
			"sources.compat",
			"sources.default",
		},
		opts = function()
			local icons = require("utils.icons")

			local capabilities = require("blink-cmp").get_lsp_capabilities()
			capabilities.textDocument.completion.completionItem.snippetSupport = true

			return {
				snippets = {
					preset = "default",
				},
				appearance = {
					use_nvim_cmp_as_default = false,
					nerd_font_variant = "mono",
					-- ⭐ 自定义图标
					kind_icons = icons.LazyIcons.kinds,
				},
				-- completion = {
				-- 	documentation = { auto_show = true },
				-- 	menu = {
				-- 		auto_show = true, -- 自动显示菜单
				-- 		border = "rounded",
				-- 		winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
				-- 		-- ⭐ 自定义菜单绘制
				-- 		draw = {
				-- 			columns = {
				-- 				{ "kind_icon", gap = 1 }, -- 图标 + 类型
				-- 				{ "label", "label_description", gap = 1 }, -- 提示内容 + 描述
				-- 				{ "kind", "source_name" }, -- 显示来源（LSP、Buffer等）
				-- 			},
				-- 			components = {
				-- 				-- 自定义 kind 显示（类型文本）
				-- 				kind = {
				-- 					text = function(ctx)
				-- 						return ctx.kind
				-- 					end,
				-- 					highlight = function(ctx)
				-- 						return "BlinkCmpKind" .. ctx.kind
				-- 					end,
				-- 				},
				-- 				-- 自定义 kind_icon 显示（图标）
				-- 				kind_icon = {
				-- 					text = function(ctx)
				-- 						local icon = ctx.kind_icon
				-- 						if ctx.item.source_name == "LSP" then
				-- 							local color_item = require("nvim-highlight-colors").format(
				-- 								ctx.item.documentation,
				-- 								{ kind = ctx.kind }
				-- 							)
				-- 							if color_item and color_item.abbr ~= "" then
				-- 								icon = color_item.abbr
				-- 							end
				-- 						end
				-- 						return icon .. ctx.icon_gap
				-- 					end,
				-- 					highlight = function(ctx)
				-- 						local highlight = "BlinkCmpKind" .. ctx.kind
				-- 						if ctx.item.source_name == "LSP" then
				-- 							local color_item = require("nvim-highlight-colors").format(
				-- 								ctx.item.documentation,
				-- 								{ kind = ctx.kind }
				-- 							)
				-- 							if color_item and color_item.abbr_hl_group then
				-- 								highlight = color_item.abbr_hl_group
				-- 							end
				-- 						end
				-- 						return highlight
				-- 					end,
				-- 				},
				-- 				-- kind_icon = {
				-- 				-- 	text = function(ctx)
				-- 				-- 		return ctx.kind_icon .. " "
				-- 				-- 	end,
				-- 				-- 	highlight = function(ctx)
				-- 				-- 		return "BlinkCmpKind" .. ctx.kind
				-- 				-- 	end,
				-- 				-- },
				-- 				-- ⭐ label 跟随 kind 颜色
				-- 				label = {
				-- 					text = function(ctx)
				-- 						return ctx.label
				-- 					end,
				-- 					highlight = function(ctx)
				-- 						if ctx.deprecated then
				-- 							return "BlinkCmpLabelDeprecated"
				-- 						end
				-- 						-- ⭐ 根据类型使用不同颜色
				-- 						return "BlinkCmpKind" .. ctx.kind
				-- 					end,
				-- 				},
				-- 				label_description = {
				-- 					text = function(ctx)
				-- 						return ctx.label_description or ""
				-- 					end,
				-- 					highlight = function(ctx)
				-- 						-- ⭐ 描述也跟随 kind 颜色，但更淡一些
				-- 						return "BlinkCmpKindDescription" .. ctx.kind
				-- 					end,
				-- 				},
				-- 				-- ⭐ 自定义 source_name 组件
				-- 				source_name = {
				-- 					text = function(ctx)
				-- 						return " [" .. ctx.source_name .. "]"
				-- 					end,
				-- 					highlight = function(ctx)
				-- 						-- 根据不同来源使用不同高亮
				-- 						return "BlinkCmpSource" .. ctx.source_name:gsub("^%l", string.upper)
				-- 					end,
				-- 				},
				-- 			},
				-- 		},
				-- 	},
				-- 	list = {
				-- 		selection = { preselect = true, auto_insert = true },
				-- 	},
				-- },
				sources = {
					default = {
						"lsp",
						"path",
						"snippets",
						"buffer",
						"cmdline",
						"tailwind",
						"tailwindcss",
						"digraphs",
						"ripgrep",
						"emoji",
						"nerdfont",
					},
					per_filetype = {
						lua = { inherit_defaults = true, "lazydev" },
					},
					providers = {
						lazydev = {
							name = "LazyDev",
							module = "lazydev.integrations.blink",
							score_offset = 100,
						},
						lsp = {
							enabled = true,
							name = "LSP",
							module = "blink.cmp.sources.lsp",
							fallbacks = { "buffer" },
							score_offset = 100,
							opts = { tailwind_color_icon = "██" },
						},
						path = {
							name = "Path",
							score_offset = 95,
						},
						buffer = {
							name = "Buffer",
							score_offset = 90,
						},
						snippets = {
							name = "Snippets",
							score_offset = 80,
						},
						cmdline = {
							module = "blink.cmp.sources.cmdline",
						},
						digraphs = {
							name = "digraphs",
							module = "blink.compat.source",
							score_offset = 10,
							opts = {
								cache_digraphs_on_start = true,
							},
						},
						tailwind = {
							name = "Tailwind",
							module = "blink.cmp.sources.lsp",
							score_offset = 50,
							opts = {},
						},
						tailwindcss = {
							name = "TailwindCSS",
							module = "blink.cmp.sources.lsp",
							score_offset = 50,
							opts = {},
						},
						ripgrep = {
							module = "blink-ripgrep",
							name = "Ripgrep",
							score_offset = 20,
							opts = {},
						},
						emoji = {
							module = "blink-emoji",
							name = "Emoji",
							score_offset = 30,
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
							score_offset = 30,
							opts = { insert = true },
						},
						css_vars = {
							name = "CssVars",
							module = "css-vars.blink",
							score_offset = 35,
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
			}
		end,
	},
}
