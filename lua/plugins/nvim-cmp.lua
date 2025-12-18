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
		"hrsh7th/nvim-cmp",
		event = { "InsertEnter", "CmdlineEnter" },
		dependencies = {
			"hrsh7th/cmp-buffer",
			"rasulomaroff/cmp-bufname",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-emoji",
			"lukas-reineke/cmp-rg",
			"dmitmel/cmp-digraphs",
			"neovim/nvim-lspconfig",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"jcha0713/cmp-tw2css",
			{
				"roobert/tailwindcss-colorizer-cmp.nvim",
				config = function()
					require("tailwindcss-colorizer-cmp").setup({
						color_square_width = 2,
					})
				end,
			},
			"dcampos/cmp-emmet-vim",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				window = {
					completion = {
						winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
						border = "rounded",
						side_padding = 2,
						max_height = 100,
					},
				},
				formatting = {
					fields = { "icon", "abbr", "menu", "kind" },
					format = function(entry, vim_item)
						local icons = require("utils.icons")
						local twd_formatter = require("tailwindcss-colorizer-cmp").formatter

						vim_item.icon = (icons.LazyIcons.kinds[vim_item.kind] or "")
						vim_item.kind = vim_item.kind .. " 🔚"

						return twd_formatter(entry, vim_item)
					end,
				},
				sources = {
					{ name = "nvim_lsp" },
					{ name = "nvim_lsp_signature_help" },
					{ name = "nvim_lua" },
					{ name = "path" },
					{
						name = "emmet_vim",
						option = {
							filetypes = {
								"xml",
								"html",
								"javascriptreact",
								"typescriptreact",
								"jsx",
								"tsx",
								"css",
								"sass",
								"scss",
								"less",
								"heex",
								"vue",
							},
						},
					},
					{ name = "rg" },
					{ name = "buffer" },
					{
						name = "bufname",
						option = {
							current_buf_only = false,
							bufs = function()
								return vim.api.nvim_list_bufs()
							end,
							extractor = function(filename)
								return { filename:match("[^.]*") }
							end,
						},
					},
					{ name = "luasnip" },
					{ name = "emoji" },
					{ name = "digraphs" },
					{ name = "cmp-tw2css" },
				},
				mapping = {
					["<CR>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							if luasnip.expandable() then
								luasnip.expand()
							else
								cmp.confirm({
									select = true,
								})
							end
						else
							fallback()
						end
					end),

					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.locally_jumpable(1) then
							luasnip.jump(1)
						else
							fallback()
						end
					end, { "i", "s" }),

					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),

					["<C-j>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.locally_jumpable(1) then
							luasnip.jump(1)
						else
							fallback()
						end
					end, { "i", "s" }),

					["<C-k>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				},
			})
		end,
	},
}
