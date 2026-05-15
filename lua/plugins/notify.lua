local notify = require("notify")
local noice = require("noice")

notify.setup({
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
})
vim.notify = notify

noice.setup({
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
		long_message_to_split = false, -- 长消息发送到分割窗口
		lsp_doc_border = true, -- 为文档和悬停添加边框
	},
})

vim.keymap.set("c", "<S-Enter>", function()
	noice.redirect(vim.fn.getcmdline())
end, { desc = "Redirect Cmdline" })

vim.keymap.set("n", "<leader>nl", function()
	noice.cmd("last")
end, { desc = "Noice Last Message" })
vim.keymap.set("n", "<leader>nh", function()
	noice.cmd("history")
end, { desc = "Noice History" })
vim.keymap.set("n", "<leader>na", function()
	noice.cmd("all")
end, { desc = "Noice All" })
vim.keymap.set("n", "<leader>nd", function()
	noice.cmd("dismiss")
end, { desc = "Noice Dismiss All" })
vim.keymap.set("n", "<leader>nt", function()
	noice.cmd("pick")
end, { desc = "Noice Picker" })

vim.keymap.set({ "i", "n", "s" }, "<C-f>", function()
	if not require("noice.lsp").scroll(4) then
		return "<C-f>"
	end
end, { desc = "Scroll Forward", silent = true, expr = true })
vim.keymap.set({ "i", "n", "s" }, "<C-b>", function()
	if not require("noice.lsp").scroll(-4) then
		return "<C-b>"
	end
end, { desc = "Scroll Backward", silent = true, expr = true })
