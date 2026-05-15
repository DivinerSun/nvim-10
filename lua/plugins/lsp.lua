local cmp = require("blink.cmp")

require("blink.compat").setup()
require("blink-ripgrep").setup()
require("codeium").setup()

local fuzzy_implementation = "prefer_rust"
if not cmp.library_available() then
	local build_ok = pcall(function()
		cmp.build():wait(60000)
	end)

	if not build_ok then
		fuzzy_implementation = "lua"
	end
end

local capabilities = cmp.get_lsp_capabilities()

vim.diagnostic.config({
	virtual_text = {
		spacing = 4,
		source = "if_many",
	},
	float = {
		border = "rounded",
		source = true,
	},
	severity_sort = true,
	signs = true,
	underline = true,
})

vim.keymap.set("i", "<C-g>", function()
	return vim.fn["codeium#Accept"]()
end, { expr = true, silent = true, desc = "Codeium Accept" })
vim.keymap.set("i", "<C-x>", function()
	return vim.fn["codeium#Clear"]()
end, { expr = true, silent = true, desc = "Codeium Clear" })

cmp.setup({
	keymap = {
		preset = "none",
		["<CR>"] = { "accept", "fallback" },
		["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
		["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
		["<C-j>"] = {
			function(cmp)
				cmp.select_next({ count = 3 })
			end,
		},
		["<C-k>"] = {
			function(cmp)
				cmp.select_prev({ count = 3 })
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
		nerd_font_variant = "mono",
	},
	completion = {
		menu = {
			winblend = 0,
		},
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 200,
			window = {
				winblend = 0,
			},
		},
	},
	signature = {
		window = {
			winblend = 0,
		},
	},
	sources = {
		default = { "lsp", "path", "buffer", "codeium", "snippets", "ripgrep", "emoji", "nerdfont" },
		providers = {
			codeium = { name = "Codeium", module = "codeium.blink", async = true },
			ripgrep = {
				module = "blink-ripgrep",
				name = "Ripgrep",
				opts = {},
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
	fuzzy = {
		implementation = fuzzy_implementation,
	},
})

local servers = {
	"lua_ls",
	"rust_analyzer",
	"ts_ls",
	"vue_ls",
	"html",
	"cssls",
	"tailwindcss",
	"eslint",
	"emmet_language_server",
	"jsonls",
	"yamlls",
	"taplo",
	"cspell_ls",
}

require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = servers,
	automatic_enable = false,
})
require("lsp_lines").setup()

local vue_language_server_path =
	vim.fn.expand("$HOME/.local/share/nvim/mason/packages/vue-language-server/node_modules/@vue/language-server")

local server_configs = {
	cspell_ls = {
		filetypes = {
			"css",
			"gitcommit",
			"html",
			"javascript",
			"javascriptreact",
			"json",
			"jsonc",
			"lua",
			"markdown",
			"rust",
			"scss",
			"toml",
			"typescript",
			"typescriptreact",
			"vue",
			"yaml",
		},
		settings = {
			cspell = {
				enabled = true,
				diagnosticLevel = "Hint",
			},
		},
	},
	lua_ls = {
		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					checkThirdParty = false,
				},
				telemetry = {
					enable = false,
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
		},
		settings = {
			tailwindCSS = {
				validate = true,
				classAttributes = { "class", "className", "classList", "ngClass" },
				includeLanguages = {
					eelixir = "html-eex",
					eruby = "erb",
					htmlangular = "html",
					templ = "html",
					vue = "html",
				},
				lint = {
					cssConflict = "warning",
					invalidApply = "error",
					invalidConfigPath = "error",
					invalidScreen = "error",
					invalidTailwindDirective = "error",
					invalidVariant = "error",
					recommendedVariantOrder = "warning",
				},
				experimental = {
					classRegex = {
						{ "class\\s*[:=]\\s*[\"'`]([^\"'`]*)[\"'`]" },
						{ "className\\s*[:=]\\s*[\"'`]([^\"'`]*)[\"'`]" },
						{ "classList\\s*[:=]\\s*[\"'`]([^\"'`]*)[\"'`]" },
						{ "cn\\(([^)]*)\\)", "[\"'`]([^\"'`]*)[\"'`]" },
						{ "clsx\\(([^)]*)\\)", "[\"'`]([^\"'`]*)[\"'`]" },
						{ "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*)[\"'`]" },
						{ "tv\\(([^)]*)\\)", "[\"'`]([^\"'`]*)[\"'`]" },
						{ "tw`([^`]*)" },
					},
				},
			},
		},
	},
	cssls = {
		settings = {
			css = {
				lint = {
					unknownAtRules = "ignore",
				},
			},
			scss = {
				lint = {
					unknownAtRules = "ignore",
				},
			},
			less = {
				lint = {
					unknownAtRules = "ignore",
				},
			},
		},
	},
	emmet_language_server = {
		filetypes = {
			"css",
			"eruby",
			"html",
			"javascriptreact",
			"less",
			"sass",
			"scss",
			"typescriptreact",
			"vue",
		},
	},
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
					location = vue_language_server_path,
					languages = { "vue" },
				},
			},
		},
	},
}

for _, server in ipairs(servers) do
	if server ~= "rust_analyzer" then
		local config = vim.tbl_deep_extend("force", {
			capabilities = capabilities,
		}, server_configs[server] or {})

		vim.lsp.config(server, config)
		vim.lsp.enable(server)
	end
end

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("user_lsp_attach", { clear = true }),
	callback = function(event)
		local client = vim.lsp.get_client_by_id(event.data.client_id)

		-- cspell 只显示下划线，不显示 virtual text / signs / float
		if client and client.name == "cspell_ls" then
			vim.diagnostic.config({
				virtual_text = false,
				signs = false,
				underline = true,
				float = true,
			}, vim.lsp.diagnostic.get_namespace(event.data.client_id))
		end

		local map = function(mode, lhs, rhs, desc)
			vim.keymap.set(mode, lhs, rhs, {
				buffer = event.buf,
				desc = desc,
				silent = true,
			})
		end

		map("n", "gd", vim.lsp.buf.definition, "Go to definition")
		map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
		map("n", "gr", vim.lsp.buf.references, "Go to references")
		map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
		map("n", "K", vim.lsp.buf.hover, "Hover documentation")
		map("n", "<leader>cr", vim.lsp.buf.rename, "Rename symbol")
		map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")
		map("n", "<leader>cd", vim.diagnostic.open_float, "Line diagnostics")
		map("n", "[d", vim.diagnostic.goto_prev, "Previous diagnostic")
		map("n", "]d", vim.diagnostic.goto_next, "Next diagnostic")
		-- 切换多行显示LSP错误信息
		map({ "n", "v", "x" }, "<A-i>", require("lsp_lines").toggle, "Toggle lsp_lines")
	end,
})
