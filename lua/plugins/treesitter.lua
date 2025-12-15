return {
	-- 安装 TreeSitter
	-- brew install tree-sitter
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "master",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			local configs = require("nvim-treesitter.configs")
			local funcs = require("utils/funcs")

			configs.setup({
				ensure_installed = {
					"bash",
					"c",
					"diff",
					"html",
					"jsdoc",
					"json",
					"jsonc",
					"lua",
					"luadoc",
					"luap",
					"markdown",
					"markdown_inline",
					"printf",
					"python",
					"query",
					"regex",
					"vim",
					"vimdoc",
					"xml",
					"yaml",
					"query",
					"elixir",
					"heex",
					"css",
					"scss",
					"javascript",
					"typescript",
					"tsx",
					"vue",
					"toml",
					"rust",
				},
				auto_install = true,
				sync_install = false,
				highlight = { enable = true },
				indent = { enable = true },
				folds = { enable = true },
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<Enter>",
						node_incremental = "<Enter>",
						scope_incremental = false,
						node_decremental = "<Backspace>",
					},
				},
			})

			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("lazyvim_treesitter", { clear = true }),
				callback = function(ev)
					local ft, lang = ev.match, vim.treesitter.language.get_lang(ev.match)
					if not funcs.have(ft) then
						return
					end

					local function enabled(feat, query)
						local f = opts[feat] or {}
						return f.enable ~= false
							and not (type(f.disable) == "table" and vim.tbl_contains(f.disable, lang))
							and funcs.have(ft, query)
					end

					-- highlighting
					if enabled("highlight", "highlights") then
						pcall(vim.treesitter.start, ev.buf)
					end

					-- indents
					if enabled("indent", "indents") then
						funcs.set_default("indentexpr", "v:lua.LazyVim.treesitter.indentexpr()")
					end

					-- folds
					if enabled("folds", "folds") then
						if funcs.set_default("foldmethod", "expr") then
							funcs.set_default("foldexpr", "v:lua.LazyVim.treesitter.foldexpr()")
						end
					end
				end,
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		init = function()
			local configs = require("nvim-treesitter.configs")
			configs.setup({
				textobjects = {
					select = {
						enable = true,
						lookahead = true,
						keymaps = {
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["am"] = "@comment.outer",
							["ac"] = "@class.outer",
							["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
							["as"] = { query = "@local.scope", query_group = "locals", desc = "Select language scope" },
						},
						selection_modes = {
							["@parameter.outer"] = "v",
							["@function.outer"] = "V",
							["@class.outer"] = "<c-v>",
						},
						include_surrounding_whitespace = true,
					},
					swap = {
						enable = true,
						swap_next = {
							["<leader>ca"] = "@parameter.inner",
						},
						swap_previous = {
							["<leader>cA"] = "@parameter.inner",
						},
					},
				},
			})
		end,
	},
	-- 代码块顶部固定
	{
		"nvim-treesitter/nvim-treesitter-context",
		config = function()
			-- 跳转到被固定行的代码位置
			vim.keymap.set("n", "<A-s>", function()
				require("treesitter-context").go_to_context(vim.v.count1)
			end, { noremap = true, silent = true, desc = "Goto Context" })

			require("treesitter-context").setup({
				enable = true,
				max_lines = 0,
				min_window_height = 0,
				line_numbers = true,
				multiline_threshold = 20,
				trim_scope = "outer",
				mode = "cursor",
				separator = nil,
				zindex = 20,
				on_attach = nil,
			})
		end,
	},
}
