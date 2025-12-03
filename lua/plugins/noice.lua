return {
	-- ⭐ 浮动命令行、搜索框、消息框
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		opts = {
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
			-- ⭐ 消息配置
			messages = {
				enabled = true, -- 启用浮动消息
				view = "notify", -- 使用 notify 样式
				view_error = "notify", -- 错误消息
				view_warn = "notify", -- 警告消息
				view_history = "messages", -- :messages 历史
				view_search = "virtualtext", -- 搜索计数
			},
			-- ⭐ 弹出菜单（自动补全）
			popupmenu = {
				enabled = true, -- 启用弹出菜单
				backend = "nui", -- 使用 nui | "cmp"
				kind_icons = {}, -- 使用默认图标
			},
			-- ⭐ 重定向输出
			redirect = {
				view = "popup",
				filter = { event = "msg_show" },
			},
			-- ⭐ 通知配置
			notify = {
				enabled = true,
				view = "notify",
			},
			-- ⭐ Commands 配置
			commands = {
				history = {
					view = "split",
					opts = { enter = true, format = "details" },
					filter = {
						any = {
							{ event = "notify" },
							{ error = true },
							{ warning = true },
							{ event = "msg_show", kind = { "" } },
							{ event = "lsp", kind = "message" },
						},
					},
				},
				last = {
					view = "popup",
					opts = { enter = true, format = "details" },
					filter = {
						any = {
							{ event = "notify" },
							{ error = true },
							{ warning = true },
							{ event = "msg_show", kind = { "" } },
							{ event = "lsp", kind = "message" },
						},
					},
					filter_opts = { count = 1 },
				},
				errors = {
					view = "popup",
					opts = { enter = true, format = "details" },
					filter = { error = true },
					filter_opts = { reverse = true },
				},
				all = {
					view = "split",
					opts = { enter = true, format = "details" },
					filter = {},
				},
			},
			-- ⭐ LSP 配置
			lsp = {
				progress = {
					enabled = true,
					format = "lsp_progress",
					format_done = "lsp_progress_done",
					throttle = 1000 / 30, -- 频率限制
					view = "mini",
				},
				hover = {
					enabled = true,
					silent = false, -- 设为 true 禁用消息
					view = nil, -- nil 使用默认浮动窗口
					opts = {}, -- 合并到现有选项
				},
				signature = {
					enabled = true,
					auto_open = {
						enabled = true,
						trigger = true, -- 自动显示签名帮助
						luasnip = true, -- 在跳转时打开
						throttle = 50, -- 去抖延迟
					},
					view = nil, -- nil 使用默认浮动窗口
					opts = {}, -- 合并到现有选项
				},
				message = {
					enabled = true,
					view = "notify",
					opts = {},
				},
				documentation = {
					view = "hover",
					opts = {
						lang = "markdown",
						replace = true,
						render = "plain",
						format = { "{message}" },
						win_options = { concealcursor = "n", conceallevel = 3 },
					},
				},
			},
			-- ⭐ Markdown 渲染
			markdown = {
				hover = {
					["|(%S-)|"] = vim.cmd.help, -- vim 帮助标签
					["%[.-%]%((%S-)%)"] = require("noice.util").open, -- markdown 链接
				},
				highlights = {
					["|%S-|"] = "@text.reference",
					["@%S+"] = "@parameter",
					["^%s*(Parameters:)"] = "@text.title",
					["^%s*(Return:)"] = "@text.title",
					["^%s*(See also:)"] = "@text.title",
					["{%S-}"] = "@parameter",
				},
			},
			-- ⭐ 健康检查
			health = {
				checker = true, -- 启动时检查配置问题
			},
			-- ⭐ 预设配置
			presets = {
				bottom_search = false, -- 使用经典的底部搜索框
				command_palette = true, -- 命令面板样式的命令行
				long_message_to_split = true, -- 长消息发送到分割窗口
				inc_rename = true, -- 启用 inc-rename.nvim 的输入对话框
				lsp_doc_border = true, -- 为文档和悬停添加边框
			},
			inc_rename = {
				cmdline = {
					format = {
						IncRename = { icon = " " },
					},
				},
			},

			-- ⭐ 路由规则
			routes = {
				-- 过滤保存文件消息
				{
					filter = {
						event = "msg_show",
						kind = "",
						find = "written",
					},
					opts = { skip = true },
				},
				-- 过滤 "w" 命令的所有输出
				{
					filter = {
						event = "msg_show",
						any = {
							{ find = "written" },
							{ find = "%d+L, %d+B" },
							{ find = "lines? --" },
						},
					},
					opts = { skip = true },
				},
				-- 过滤 yanked 消息
				{
					filter = {
						event = "msg_show",
						find = "lines? yanked",
					},
					opts = { skip = true },
				},
				-- 过滤 more/less lines
				{
					filter = {
						event = "msg_show",
						any = {
							{ find = "more lines?" },
							{ find = "fewer lines?" },
							{ find = "change; before" },
							{ find = "change; after" },
						},
					},
					opts = { skip = true },
				},
				-- 过滤搜索计数（使用 virtualtext 显示）
				{
					filter = {
						event = "msg_show",
						kind = "search_count",
					},
					opts = { skip = true },
				},
				-- 过滤 "已在顶部/底部" 消息
				{
					filter = {
						event = "msg_show",
						any = {
							{ find = "Already at" },
							{ find = "No more items" },
						},
					},
					opts = { skip = true },
				},
			},
			-- ⭐ 视图配置
			views = {
				cmdline_popup = {
					position = {
						row = "50%", -- 居中显示
						col = "50%",
					},
					size = {
						width = 60,
						height = "auto",
					},
					border = {
						style = "rounded",
						padding = { 0, 1 },
					},
					filter_options = {
						filter = {
							event = "msg_show",
							kind = "",
							find = "written",
						},
						opts = { skip = true },
					},
					win_options = {
						winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
					},
				},
				popupmenu = {
					relative = "editor",
					position = {
						row = "50%",
						col = "50%",
					},
					size = {
						width = 60,
						height = 10,
					},
					border = {
						style = "rounded",
						padding = { 0, 1 },
					},
					win_options = {
						winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
					},
				},
			},
		},
	},
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
				ERROR = "",
				WARN = "",
				INFO = "",
				DEBUG = "",
				TRACE = "✎",
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
}
