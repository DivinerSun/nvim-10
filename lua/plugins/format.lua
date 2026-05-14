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
		markdown = { "prettier" },
		markdown_inline = { "prettier" },
		rust = { "rustfmt" },
		sass = { "prettier" },
		scss = { "prettier" },
		typescript = { "prettier" },
		typescriptreact = { "prettier" },
		vue = { "prettier" },
		yaml = { "prettier" },
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
