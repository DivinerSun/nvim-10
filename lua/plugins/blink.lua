return {
	-- Windsurf
	{
		"Exafunction/windsurf.vim",
		event = "BufEnter",
		init = function()
			vim.g.codeium_disable_bindings = 1
		end,
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
		version = "2.*",
		lazy = true,
		opts = {},
	},
	{
		"saghen/blink.cmp",
		version = "1.*",
		dependencies = {
			"saghen/blink.lib",
			"dmitmel/cmp-digraphs",
			"onsails/lspkind.nvim",
			"xieyonn/blink-cmp-dat-word",
			"Kaiser-Yang/blink-cmp-dictionary",
			"rafamadriz/friendly-snippets",
			"bydlw98/blink-cmp-env",
			"yehuohan/blink-cmp-im",
			{
				"mikavilpas/blink-ripgrep.nvim",
				version = "*",
			},
			"jdrupal-dev/css-vars.nvim",
			"moyiz/blink-emoji.nvim",
			"MahanRahmati/blink-nerdfont.nvim",
		},
		opts = {
			keymap = {
				preset = "enter",
				["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
				["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
				["<C-j>"] = {
					function(cmp)
						cmp.select_next({ count = 5 })
					end,
				},
				["<C-k>"] = {
					function(cmp)
						cmp.select_prev({ count = 5 })
					end,
				},
				["<C-i>"] = { "show_signature", "hide_signature", "fallback" },
				["<C-d>"] = { "show", "show_documentation", "hide_documentation" },
				["<C-b>"] = {
					function(cmp)
						cmp.scroll_documentation_up(3)
					end,
				},
				["<C-f>"] = {
					function(cmp)
						cmp.scroll_documentation_down(3)
					end,
				},
			},
			appearance = {
				-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
				nerd_font_variant = "normal",
			},
			signature = { enabled = true },
			completion = {
				documentation = { auto_show = true, auto_show_delay_ms = 500 },
				ghost_text = { enabled = true },
				menu = {
					auto_show = true,
					draw = {
						components = {
							kind_icon = {
								text = function(ctx)
									local icon = ctx.kind_icon
									if vim.tbl_contains({ "Path" }, ctx.source_name) then
										local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
										if dev_icon then
											icon = dev_icon
										end
									elseif ctx.kind == "Color" then
										icon = "██"
									else
										icon = require("lspkind").symbol_map[ctx.kind] or ""
									end

									return icon .. ctx.icon_gap
								end,
								highlight = function(ctx)
									local hl = ctx.kind_hl
									if vim.tbl_contains({ "Path" }, ctx.source_name) then
										local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
										if dev_icon then
											hl = dev_hl
										end
									elseif ctx.kind == "Color" then
										local doc = ctx.item and ctx.item.documentation
										local content
										if type(doc) == "string" then
											content = doc
										elseif type(doc) == "table" then
											content = doc.value
										end
										if content then
											local hex = content:match("#%x%x%x%x%x%x") or content:match("#%x%x%x")
											if hex and #hex == 4 then
												hex = "#"
													.. hex:sub(2, 2):rep(2)
													.. hex:sub(3, 3):rep(2)
													.. hex:sub(4, 4):rep(2)
											end
											if hex then
												local hl_name = "BlinkCmpKindTw_" .. hex:sub(2)
												if vim.fn.hlexists(hl_name) == 0 then
													vim.api.nvim_set_hl(0, hl_name, { fg = hex })
												end
												hl = hl_name
											end
										end
									end
									return hl
								end,
							},
						},
					},
				},
			},
			sources = {
				default = {
					"lazydev",
					"lsp",
					"path",
					"snippets",
					"buffer",
					"digraphs",
					"cmdline",
					"datword",
					"dictionary",
					"env",
					"im",
					"ripgrep",
					"emoji",
					"nerdfont",
				},
				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						score_offset = 100,
					},
					lsp = {
						name = "LSP",
						module = "blink.cmp.sources.lsp",
						transform_items = function(_, items)
							return vim.tbl_filter(function(item)
								return item.kind ~= require("blink.cmp.types").CompletionItemKind.Keyword
							end, items)
						end,
					},
					path = {
						opts = {
							get_cwd = function(_)
								return vim.fn.getcwd()
							end,
						},
					},
					digraphs = {
						name = "Digraphs",
						module = "blink.compat.source",
						score_offset = -3,
						opts = {
							cache_digraphs_on_start = true,
						},
					},
					cmdline = {
						module = "blink.cmp.sources.cmdline",
					},
					datword = {
						name = "Word",
						module = "blink-cmp-dat-word",
						opts = {
							paths = {
								"/usr/share/dict/words",
							},
						},
					},
					dictionary = {
						module = "blink-cmp-dictionary",
						name = "Dict",
						min_keyword_length = 1,
						opts = {
							force_fallback = true,
						},
					},
					env = {
						name = "Env",
						module = "blink-cmp-env",
						opts = {},
					},
					im = { name = "IM", module = "blink_cmp_im" },
					ripgrep = {
						module = "blink-ripgrep",
						name = "Ripgrep",
						opts = {},
					},
					css_vars = {
						name = "css-vars",
						module = "css-vars.blink",
						opts = {
							search_extensions = { ".js", ".ts", ".jsx", ".tsx" },
						},
					},
					emoji = {
						module = "blink-emoji",
						name = "Emoji",
						score_offset = 15,
						opts = {
							insert = true,
						},
					},
					nerdfont = {
						module = "blink-nerdfont",
						name = "Nerd Fonts",
						score_offset = 15,
						opts = {
							insert = true,
						},
					},
				},
			},
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { "sources.default" },
	},
	{
		"windwp/nvim-ts-autotag",
		event = "InsertEnter",
		config = function()
			require("nvim-ts-autotag").setup({
				opts = {
					enable_close = true, -- Auto close tags
					enable_rename = true, -- Auto rename pairs of tags
					enable_close_on_slash = true, -- Auto close on trailing </
				},
			})
		end,
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},
}
