return {
	-- ui 基础组件
	{ "MunifTanjim/nui.nvim", lazy = true },
	-- Icons 图标
	{
		"nvim-mini/mini.icons",
		lazy = true,
		opts = {
			file = {
				[".keep"] = { glyph = "󰊢", hl = "MiniIconsGrey" },
				["devcontainer.json"] = { glyph = "", hl = "MiniIconsAzure" },
			},
			filetype = {
				dotenv = { glyph = "", hl = "MiniIconsYellow" },
			},
		},
		init = function()
			package.preload["nvim-web-devicons"] = function()
				require("mini.icons").mock_nvim_web_devicons()
				return package.loaded["nvim-web-devicons"]
			end
		end,
	},
	-- 自定义底部状态栏
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = function()
			vim.o.laststatus = vim.g.lualine_laststatus

			local icons = require("utils.icons")

			local conditions = {
				buffer_not_empty = function()
					return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
				end,
				hide_in_width = function()
					return vim.fn.winwidth(0) > 80
				end,
				check_git_workspace = function()
					local filepath = vim.fn.expand("%:p:h")
					local gitdir = vim.fn.finddir(".git", filepath .. ";")
					return gitdir and #gitdir > 0 and #gitdir < #filepath
				end,
			}

			local diagnostics = {
				"diagnostics",
				symbols = {
					error = icons.diagnostics.Error .. " ",
					warn = icons.diagnostics.Warn .. " ",
					info = icons.diagnostics.Info .. " ",
					hint = icons.diagnostics.Hint .. " ",
				},
				colored = true,
				update_in_insert = false,
				always_visible = false,
			}

			local diff = {
				"diff",
				symbols = {
					added = icons.git.Added .. " ",
					modified = icons.git.Modified .. " ",
					removed = icons.git.Removed .. " ",
				},
				source = function()
					local gitsigns = vim.b.gitsigns_status_dict
					if gitsigns then
						return {
							added = gitsigns.added,
							modified = gitsigns.changed,
							removed = gitsigns.removed,
						}
					end
				end,
			}

			local mode = {
				"mode",
				fmt = function(str)
					return "--" .. str .. "--"
				end,
			}

			local branch = {
				"branch",
				icons_enabled = true,
				icon = icons.git.Branch,
			}

			local location = {
				"location",
				padding = 1,
				color = { fg = "#FFFFFF", bg = "#d86079" },
			}

			-- cool function for progress
			local progress = function()
				local current_line = vim.fn.line(".")
				local total_lines = vim.fn.line("$")
				local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
				local line_ratio = current_line / total_lines
				local index = math.ceil(line_ratio * #chars)
				return chars[index] .. " " .. math.floor(line_ratio * 100)
			end

			local spaces = function()
				return icons.ui.Tab .. " " .. vim.api.nvim_get_option_value("shiftwidth", {})
			end

			local file_name = {
				"filename",
				cond = conditions.buffer_not_empty,
			}

			return {
				options = {
					theme = "auto",
					globalstatus = true,
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },
					disabled_filetypes = {
						"TelescopePrompt",
						"packer",
						"alpha",
						"dashboard",
						"NvimTree",
						"Outline",
						"DressingInput",
						"toggleterm",
						"lazy",
						"mason",
						statusline = { "dashboard", "alpha", "starter" },
					},
					refresh = {
						statusline = 100,
						tabline = 100,
						winbar = 100,
						refresh_time = 16, -- ~60fps
						events = {
							"WinEnter",
							"BufEnter",
							"BufWritePost",
							"SessionLoadPost",
							"FileChangedShellPost",
							"VimResized",
							"Filetype",
							"CursorMoved",
							"CursorMovedI",
							"ModeChanged",
						},
					},
					icons_enabled = true,
					always_divide_middle = true,
					always_show_tabline = true,
				},
				sections = {
					lualine_a = {
						{
							"fileformat",
							symbols = {
								mac = "", -- e711
								unix = "", -- e711
								dos = "", -- e70f
								lunix = "", -- e712
							},
						},
					},
					lualine_b = { mode, branch },
					lualine_c = { diagnostics, diff },
					lualine_x = {
						"lsp_status",
						spaces,
						"encoding",
						"filesize",
					},
					lualine_y = { location },
					lualine_z = { { progress, color = { fg = "#FF99CC" } } },
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { file_name },
					lualine_x = { "location" },
					lualine_y = {},
					lualine_z = {},
				},
				tabline = {},
				extensions = { "neo-tree", "lazy", "fzf" },
			}
		end,
	},
	-- 配置 IncLine 导航
	{
		"b0o/incline.nvim",
		dependencies = {
			{
				"SmiteshP/nvim-navic",
				dependencies = "neovim/nvim-lspconfig",
			},
		},
		opts = function()
			local opts = {
				highlight = {
					groups = {
						InclineNormal = { guibg = "#822455" },
					},
				},
				window = {
					padding = 0,
					margin = {
						horizontal = 0,
						vertical = 0,
					},
				},
				debounce_threshold = { falling = 500, rising = 250 },
				render = function(props)
					local devicons = require("nvim-web-devicons")
					local navic = require("nvim-navic")

					local icons = require("utils.icons")

					local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
					if filename == "" then
						filename = "[No Name]"
					end
					local ft_icon, ft_color = devicons.get_icon_color(filename)
					local modified = vim.bo[props.buf].modified

					local function get_git_diff()
						local icons_git = {
							added = icons.git.Added,
							changed = icons.git.Modified,
							removed = icons.git.Removed,
						}
						local signs = vim.b[props.buf].gitsigns_status_dict
						local labels = {}
						if signs == nil then
							return labels
						end
						for name, icon in pairs(icons_git) do
							if tonumber(signs[name]) and signs[name] > 0 then
								table.insert(
									labels,
									{ " " .. icon .. " " .. signs[name] .. " ", group = "Diff" .. name }
								)
							end
						end
						if #labels > 0 then
							table.insert(labels, { "┊ " })
						end
						return labels
					end

					local function get_diagnostic_label()
						local icons_d = {
							error = icons.diagnostics.Error,
							warn = icons.diagnostics.Warn,
							info = icons.diagnostics.Info,
							hint = icons.diagnostics.Hint,
						}
						local label = {}

						for severity, icon in pairs(icons_d) do
							local n = #vim.diagnostic.get(
								props.buf,
								{ severity = vim.diagnostic.severity[string.upper(severity)] }
							)
							if n > 0 then
								table.insert(
									label,
									{ " " .. icon .. " " .. n .. " ", group = "DiagnosticSign" .. severity }
								)
							end
						end
						if #label > 0 then
							table.insert(label, { "┊ " })
						end

						return label
					end

					local res = {
						{ get_diagnostic_label() },
						{ get_git_diff() },
						{ (ft_icon or "") .. " ", guifg = ft_color, guibg = "none" },
						{ filename, gui = modified and "bold,italic" or "bold" },
						{ " ┊  " .. vim.api.nvim_win_get_number(props.win), group = "DevIconWindows" },
						guibg = "#44406e",
					}

					if props.focused then
						for _, item in ipairs(navic.get_data(props.buf) or {}) do
							table.insert(res, {
								{ " > ", group = "NavicSeparator" },
								{ item.icon, group = "NavicIcons" .. item.type },
								{ item.name, group = "NavicText" },
							})
						end
					end
					table.insert(res, " ")
					return res
				end,
			}
			return opts
		end,
	},
	-- Noice 配置
	{
		"folke/noice.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
			-- ⭐ 通知插件（增强 noice.nvim）
			{
				"rcarriga/nvim-notify",
				opts = {
					timeout = 3000,
					max_height = function()
						return math.floor(vim.o.lines * 0.75)
					end,
					max_width = function()
						return math.floor(vim.o.columns * 0.75)
					end,
					stages = "fade_in_slide_out", -- 动画效果
					render = "default", -- 渲染样式：default | minimal | simple | compact
					background_colour = "#000000",
					fps = 60,
					icons = {
						ERROR = " ",
						WARN = " ",
						INFO = " ",
						DEBUG = " ",
						TRACE = "✎ ",
					},
					level = 2,
					minimum_width = 50,
					on_open = nil,
					on_close = nil,
					top_down = true, -- 从上到下显示
				},
				config = function(_, opts)
					require("notify").setup(opts)
					-- 设置为默认通知处理器
					vim.notify = require("notify")
				end,
			},
		},
		event = "VeryLazy",
		opts = {
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			-- ⭐ 命令行配置
			cmdline = {
				enabled = true, -- 启用浮动命令行
				view = "cmdline_popup", -- 使用弹出窗口样式
				opts = {}, -- 全局命令行选项
				format = {
					-- 不同命令的样式
					cmdline = { pattern = "^:", icon = " ", lang = "vim" },
					search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
					search_up = { kind = "search", pattern = "^%?", icon = "󰶚 ", lang = "regex" },
					filter = { pattern = "^:%s*!", icon = "󱨿 ", lang = "bash" },
					lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "󰢱 ", lang = "lua" },
					help = { pattern = "^:%s*he?l?p?%s+", icon = " " },
					input = { view = "cmdline_input", icon = "󰴓 " }, -- 用于 input()
				},
			},
			routes = {
				{
					filter = {
						event = "msg_show",
						any = {
							{ find = "%d+L, %d+B" },
							{ find = "; after #%d+" },
							{ find = "; before #%d+" },
						},
					},
					view = "mini",
				},
			},
			presets = {
				bottom_search = false, -- 使用经典的底部搜索框
				command_palette = true, -- 命令面板样式的命令行
				long_message_to_split = true, -- 长消息发送到分割窗口
				lsp_doc_border = true, -- 为文档和悬停添加边框
			},
		},
		keys = {
			{ "<leader>sn", "", desc = "+noice" },
			{
				"<S-Enter>",
				function()
					require("noice").redirect(vim.fn.getcmdline())
				end,
				mode = "c",
				desc = "Redirect Cmdline",
			},
			{
				"<leader>snl",
				function()
					require("noice").cmd("last")
				end,
				desc = "Noice Last Message",
			},
			{
				"<leader>snh",
				function()
					require("noice").cmd("history")
				end,
				desc = "Noice History",
			},
			{
				"<leader>sna",
				function()
					require("noice").cmd("all")
				end,
				desc = "Noice All",
			},
			{
				"<leader>snd",
				function()
					require("noice").cmd("dismiss")
				end,
				desc = "Dismiss All",
			},
			{
				"<leader>snt",
				function()
					require("noice").cmd("pick")
				end,
				desc = "Noice Picker (Telescope/FzfLua)",
			},
			{
				"<c-f>",
				function()
					if not require("noice.lsp").scroll(4) then
						return "<c-f>"
					end
				end,
				silent = true,
				expr = true,
				desc = "Scroll Forward",
				mode = { "i", "n", "s" },
			},
			{
				"<c-b>",
				function()
					if not require("noice.lsp").scroll(-4) then
						return "<c-b>"
					end
				end,
				silent = true,
				expr = true,
				desc = "Scroll Backward",
				mode = { "i", "n", "s" },
			},
		},
		config = function(_, opts)
			if vim.o.filetype == "lazy" then
				vim.cmd([[messages clear]])
			end
			require("noice").setup(opts)
		end,
	},
	-- Git 信息展示
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			signs = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "" },
				topdelete = { text = "" },
				changedelete = { text = "▎" },
				untracked = { text = "▎" },
			},
			signs_staged = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "" },
				topdelete = { text = "" },
				changedelete = { text = "▎" },
			},
			on_attach = function(buffer)
				local gs = package.loaded.gitsigns

				local function map(mode, l, r, desc)
					vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc, silent = true })
				end

        -- stylua: ignore start
        map("n", "]h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gs.nav_hunk("next")
          end
        end, "Next Hunk")
        map("n", "[h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gs.nav_hunk("prev")
          end
        end, "Prev Hunk")
        map("n", "]H", function() gs.nav_hunk("last") end, "Last Hunk")
        map("n", "[H", function() gs.nav_hunk("first") end, "First Hunk")
        map({ "n", "x" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
        map({ "n", "x" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
        map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
        map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
        map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
        map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview Hunk Inline")
        map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
        map("n", "<leader>ghB", function() gs.blame() end, "Blame Buffer")
        map("n", "<leader>ghd", gs.diffthis, "Diff This")
        map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
			end,
		},
	},
	{
		"gitsigns.nvim",
		opts = function()
			Snacks.toggle({
				name = "Git Signs",
				get = function()
					return require("gitsigns.config").config.signcolumn
				end,
				set = function(state)
					require("gitsigns").toggle_signs(state)
				end,
			}):map("<leader>uG")
		end,
	},
	-- 错误信息插件
	{
		"folke/trouble.nvim",
		cmd = { "Trouble" },
		opts = {
			modes = {
				lsp = {
					win = { position = "right" },
				},
			},
		},
		keys = {
			{ "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
			{ "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
			{ "<leader>cs", "<cmd>Trouble symbols toggle<cr>", desc = "Symbols (Trouble)" },
			{ "<leader>cS", "<cmd>Trouble lsp toggle<cr>", desc = "LSP references/definitions/... (Trouble)" },
			{ "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
			{ "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
			{
				"[q",
				function()
					if require("trouble").is_open() then
						local trouble = require("trouble")
						trouble.prev(trouble.View, { skip_groups = true, jump = true })
					else
						local ok, err = pcall(vim.cmd.cprev)
						if not ok then
							vim.notify(err, vim.log.levels.ERROR)
						end
					end
				end,
				desc = "Previous Trouble/Quickfix Item",
			},
			{
				"]q",
				function()
					if require("trouble").is_open() then
						local trouble = require("trouble")
						trouble.next(trouble.View, { skip_groups = true, jump = true })
					else
						local ok, err = pcall(vim.cmd.cnext)
						if not ok then
							vim.notify(err, vim.log.levels.ERROR)
						end
					end
				end,
				desc = "Next Trouble/Quickfix Item",
			},
		},
	},
	{
		"folke/todo-comments.nvim",
		cmd = { "TodoTrouble", "TodoTelescope" },
		event = { "BufReadPre", "BufNewFile" },
		opts = {},
    -- stylua: ignore
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next Todo Comment" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous Todo Comment" },
      { "<leader>xt", "<cmd>Trouble todo toggle<cr>", desc = "Todo (Trouble)" },
      { "<leader>xT", "<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
      { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo" },
      { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
    },
	},
}
