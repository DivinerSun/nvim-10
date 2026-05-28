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
		local Snacks = require("snacks")
		local map = function(mode, lhs, rhs, desc)
			vim.keymap.set(mode, lhs, rhs, {
				buffer = bufnr,
				desc = desc,
				silent = true,
			})
		end

		local function format_git_tag(item, picker)
			local a = Snacks.picker.util.align
			local fmt = require("snacks.picker.format")
			local ret = {}

			-- Tag 名称（主列）
			ret[#ret + 1] = { picker.opts.icons.git.branch or "󰚋 ", "SnacksPickerGitBranch" }
			ret[#ret + 1] = { a(item.tag or item.branch, 24, { truncate = true }), "SnacksPickerGitBranch" }
			ret[#ret + 1] = { " " }

			-- commit hash
			ret[#ret + 1] = { picker.opts.icons.git.commit, "SnacksPickerGitCommit" }
			ret[#ret + 1] = { a(item.commit, 8, { truncate = true }), "SnacksPickerGitCommit" }
			ret[#ret + 1] = { " " }

			-- 日期 + message
			if item.date then
				ret[#ret + 1] = { a(item.date, 16), "SnacksPickerGitDate" }
				ret[#ret + 1] = { " " }
			end
			Snacks.picker.highlight.extend(ret, fmt.commit_message(item, picker))

			return ret
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
		map("n", "<leader>gs", function()
			Snacks.picker.git_status()
		end, "Git Status")
		map("n", "<leader>gb", function()
			Snacks.picker.git_branches()
		end, "Git Branches")
		map("n", "<leader>gc", function()
			Snacks.picker.git_log()
		end, "Git Commits")
		map("n", "<leader>gd", function()
			Snacks.picker.git_diff()
		end, "Git Diff")
		map("n", "<leader>gf", function()
			Snacks.picker.git_files()
		end, "Git Files")
		map("n", "<leader>gg", function()
			Snacks.lazygit()
		end, "LazyGit")
		map("n", "<leader>gl", function()
			Snacks.lazygit.log_file()
		end, "LazyGit File Log")
		map("n", "<leader>gt", function()
			local cwd = Snacks.git.get_root()
			if not cwd then
				return Snacks.notify.warn("Not in a git repository")
			end
			Snacks.picker.pick({
				title = "Git Tags",
				cwd = cwd,
				cmd = "git",
				args = {
					"for-each-ref",
					"--sort=-creatordate",
					"--format=%(refname:short)\t%(objectname:short)\t%(creatordate:short)\t%(subject)",
					"refs/tags",
				},
				finder = require("snacks.picker.source.proc").proc,
				format = format_git_tag, -- "git_log",
				preview = "git_show",
				confirm = "git_checkout",
				transform = function(item)
					local tag, commit, date, subject = item.text:match("^([^\t]+)\t([^\t]+)\t([^\t]+)\t(.*)$")
					if not tag then
						return false
					end
					item.cwd = cwd
					item.branch = tag
					item.commit = commit
					item.date = date
					item.msg = subject
				end,
			})
		end, "Git Tags")
		map("n", "<leader>gw", function()
			local cwd = Snacks.git.get_root()
			if not cwd then
				return Snacks.notify.warn("Not in a git repository")
			end
			Snacks.picker.pick({
				title = "Git WorkTrees",
				cwd = cwd,
				cmd = "git",
				args = { "worktree", "list" },
				finder = require("snacks.picker.source.proc").proc,
				format = "text",
				preview = "git_log",
				confirm = "tcd",
				transform = function(item)
					local path, commit, branch = item.text:match("^(%S+)%s+(%x+)%s+%[(.-)%]$")
					if not path then
						path, commit = item.text:match("^(%S+)%s+(%x+)")
					end
					if not path then
						return false
					end
					item.cwd = cwd
					item.file = path
					item.commit = commit
					item.branch = branch
					item.text = branch and (path .. "  [" .. branch .. "]") or path
				end,
				win = {
					input = {
						keys = {
							["<C-f>"] = {
								function(picker, item)
									picker:close()
									if item then
										Snacks.picker.files({ cwd = item.file })
									end
								end,
								mode = { "n", "i" },
								desc = "Open Files in WorkTree",
							},
						},
					},
				},
			})
		end, "Git WorkTrees")
	end,
})
