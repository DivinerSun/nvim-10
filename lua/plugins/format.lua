require("mason-tool-installer").setup({
	ensure_installed = {
		"cspell-lsp",
		"css-lsp",
		"emmet-language-server",
		"eslint-lsp",
		"html-lsp",
		"json-lsp",
		"prettier",
		"rust-analyzer",
		"stylua",
		"tailwindcss-language-server",
		"taplo",
		"typescript-language-server",
		"vue-language-server",
		"yaml-language-server",
		"markdownlint-cli2",
		"markdown-toc",
	},
	auto_update = false,
	run_on_start = true,
})

require("conform").setup({
	formatters_by_ft = {
		css = { "prettier" },
		html = { "prettier" },
		javascript = { "prettier" },
		javascriptreact = { "prettier" },
		json = { "prettier" },
		jsonc = { "prettier" },
		less = { "prettier" },
		lua = { "stylua" },
		rust = { "rustfmt" },
		sass = { "prettier" },
		scss = { "prettier" },
		typescript = { "prettier" },
		typescriptreact = { "prettier" },
		vue = { "prettier" },
		yaml = { "prettier" },
		markdown = { "prettier" },
		markdown_inline = { "prettier" },
		["markdown.mdx"] = { "prettier", "markdownlint-cli2", "markdown-toc" },
	},
	formatters = {
		injected = { options = { ignore_errors = true } },
		["markdown-toc"] = {
			condition = function(_, ctx)
				for _, line in ipairs(vim.api.nvim_buf_get_lines(ctx.buf, 0, -1, false)) do
					if line:find("<!%-%- toc %-%->") then
						return true
					end
				end
			end,
		},
		["markdownlint-cli2"] = {
			condition = function(_, ctx)
				local diag = vim.tbl_filter(function(d)
					return d.source == "markdownlint"
				end, vim.diagnostic.get(ctx.buf))
				return #diag > 0
			end,
		},
	},
	format_on_save = function(bufnr)
		local disabled_filetypes = {}
		if disabled_filetypes[vim.bo[bufnr].filetype] then
			return nil
		end

		return {
			timeout_ms = 1000,
			lsp_format = "fallback",
		}
	end,
})

vim.keymap.set({ "n", "v" }, "<leader>cf", function()
	require("conform").format({
		async = true,
		lsp_format = "fallback",
	})
end, {
	desc = "Format buffer",
})
