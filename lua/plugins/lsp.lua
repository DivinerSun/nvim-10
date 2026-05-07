return {
	-- LSP 信息多行显示
	{
		"DivinerSun/lsp_lines.nvim",
		config = function()
			-- 切换多行显示LSP错误信息
			vim.keymap.set("", "<A-i>", require("lsp_lines").toggle, { desc = "Toggle lsp_lines" })
			require("lsp_lines").setup()
		end,
	},
	{
		"mason-org/mason.nvim",
		cmd = "Mason",
		keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
		build = ":MasonUpdate",
		opts_extend = { "ensure_installed" },
		opts = {
			ensure_installed = {
				"stylua",
				"shfmt",
				"taplo",
				"tailwindcss-language-server",
				"typescript-language-server",
				"vue-language-server",
			},
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		},
		config = function(_, opts)
			require("mason").setup(opts)
			local mr = require("mason-registry")
			mr:on("package:install:success", function()
				vim.defer_fn(function()
					require("lazy.core.handler.event").trigger({
						event = "FileType",
						buf = vim.api.nvim_get_current_buf(),
					})
				end, 100)
			end)

			mr.refresh(function()
				for _, tool in ipairs(opts.ensure_installed) do
					local p = mr.get_package(tool)
					if not p:is_installed() then
						p:install()
					end
				end
			end)
		end,
	},
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
		opts = {
			automatic_enable = {
				exclude = {
					"htmx",
					"lua_ls",
					"tailwindcss",
					"ts_ls",
				},
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		dependencies = { "saghen/blink.cmp" },
		opts = {
			servers = {
				lua_ls = {},
				ts_ls = {
					filetypes = {
						"javascript",
						"javascriptreact",
						"typescript",
						"typescriptreact",
						"vue",
					},
					init_options = {
						plugins = {
							{
								name = "@vue/typescript-plugin",
								location = vim.fn.expand(
									"$HOME/.local/share/nvim/mason/packages/vue-language-server/node_modules/@vue/language-server"
								),
								languages = { "vue" },
							},
						},
					},
				},
				tailwindcss = {
					filetypes = {
						"html",
						"css",
						"scss",
						"sass",
						"less",
						"postcss",
						"javascript",
						"javascriptreact",
						"typescript",
						"typescriptreact",
						"vue",
						"svelte",
						"astro",
					},
					settings = {
						tailwindCSS = {
							validate = true,
							classAttributes = { "class", "className", "classList", "ngClass" },
							experimental = {
								classRegex = {
									{ "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
									{ "cx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
									{ "tw`([^`]*)" },
									{ "tw=\"([^\"]*)" },
									{ "tw={\"([^\"}]*)" },
									{ "tw\\.\\w+`([^`]*)" },
									{ "tw\\(.*?\\)`([^`]*)" },
								},
							},
						},
					},
				},
			},
		},
		config = function(_, opts)
			local capabilities = require("blink.cmp").get_lsp_capabilities()
			for server, config in pairs(opts.servers) do
				config.capabilities = capabilities
				vim.lsp.config[server] = config
				vim.lsp.enable(server)
			end
		end,
	},
}
