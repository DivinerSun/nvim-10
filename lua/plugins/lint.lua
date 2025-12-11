return {
	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lint = require("lint")
			local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
			local eslint = lint.linters.eslint_d

			lint.linters_by_ft = {
				javascript = { "biomejs", "eslint", "eslint_d" },
				typescript = { "biomejs", "eslint", "eslint_d" },
				javascriptreact = { "biomejs", "eslint", "eslint_d" },
				typescriptreact = { "biomejs", "eslint", "eslint_d" },
				svelte = { "biomejs", "eslint", "eslint_d" },
				vue = { "biomejs", "eslint", "eslint_d" },
				python = { "ruff" },
			}

			eslint.args = {
				"--no-warn-ignored",
				"--format",
				"json",
				"--stdin",
				"--stdin-filename",
				function()
					return vim.fn.expand("%:p")
				end,
			}

			vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
				group = lint_augroup,
				callback = function()
					lint.try_lint()
				end,
			})

			vim.keymap.set("n", "<leader>cl", function()
				lint.try_lint()
			end, { desc = "Linting Current File" })
		end,
	},
}
