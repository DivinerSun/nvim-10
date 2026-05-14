require("gitsigns").setup({
	signs = {
		add = { text = "+" },
		change = { text = "~" },
		delete = { text = "_" },
		topdelete = { text = "^" },
		changedelete = { text = "~" },
		untracked = { text = "+" },
	},
	on_attach = function(bufnr)
		local gitsigns = require("gitsigns")
		local map = function(mode, lhs, rhs, desc)
			vim.keymap.set(mode, lhs, rhs, {
				buffer = bufnr,
				desc = desc,
				silent = true,
			})
		end

		map("n", "]h", gitsigns.next_hunk, "Next git hunk")
		map("n", "[h", gitsigns.prev_hunk, "Previous git hunk")
		map("n", "<leader>ghs", gitsigns.stage_hunk, "Stage hunk")
		map("n", "<leader>ghr", gitsigns.reset_hunk, "Reset hunk")
		map("v", "<leader>ghs", function()
			gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, "Stage selected hunk")
		map("v", "<leader>ghr", function()
			gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, "Reset selected hunk")
		map("n", "<leader>ghp", gitsigns.preview_hunk, "Preview hunk")
		map("n", "<leader>ghb", gitsigns.blame_line, "Blame line")
	end,
})
