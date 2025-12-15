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
}
