require("gitsigns").setup({
	signs = {
		add = { text = "▎" },
		change = { text = "▎" },
		delete = { text = "" },
		topdelete = { text = "" },
		changedelete = { text = "~" },
		untracked = { text = "┆" },
	},
	signs_staged = {
		add = { text = "▎" },
		change = { text = "▎" },
		delete = { text = "" },
		topdelete = { text = "" },
		changedelete = { text = "~" },
		untracked = { text = "┆" },
	},
	signs_staged_enable = true,
	signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
	numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
	linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
	word_diff = true, -- Toggle with `:Gitsigns toggle_word_diff`
	current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
	current_line_blame_opts = {
		virt_text = true,
		virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
		delay = 1000,
		ignore_whitespace = false,
		virt_text_priority = 100,
		use_focus = true,
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
		map("n", "<leader>gs", "<cmd>FzfLua git_status<CR>", "Git Status")
		map("n", "<leader>gb", "<cmd>FzfLua git_branches<CR>", "Git Branches")
		map("n", "<leader>gc", "<cmd>FzfLua git_commits<CR>", "Git Commits")
		map("n", "<leader>gd", "<cmd>FzfLua git_diff<CR>", "Git Diff")
		map("n", "<leader>gt", "<cmd>FzfLua git_tags<CR>", "Git Tags")
		map("n", "<leader>gw", "<cmd>FzfLua git_worktrees<CR>", "Git WorkTrees")
	end,
})
