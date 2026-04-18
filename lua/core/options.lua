-- 设置 leader 键
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 禁用 netrw banner
vim.cmd("let g:netrw_banner = 0")

-- 终端 GUI
vim.opt.termguicolors = true -- 启用真彩色
vim.opt.background = "dark" -- 设置背景
vim.opt.mouse = "a" -- 启用鼠标
vim.opt.clipboard = "unnamedplus" -- 使用系统剪贴板
vim.opt.guifont = "FiraCode Nerd Font:h18" -- 设置 GUI 字体(如果使用了 GUI)
vim.opt.guicursor = { -- 光标形状
	"n-v-c:block", -- Normal, Visual, Command 模式：方块
	"i-ci-ve:ver25", -- Insert, Command-line Insert, Visual-exclude: 竖线
	"r-cr:hor20", -- Replace, Command-line Replace: 横线
	"o:hor50", -- Operator-pending: 横线
	"a:blinkwait700-blinkoff400-blinkon250", -- 所有模式闪烁设置
}

-- 界面显示配置
vim.opt.number = true -- 显示行号
vim.opt.relativenumber = true -- 相对行号
vim.opt.signcolumn = "yes" -- 符号列（用于显示 git/lsp 符号）
vim.opt.cursorline = true -- 高亮当前行
vim.opt.cursorcolumn = true -- 高亮当前列
-- vim.opt.colorcolumn = "80,120"  -- 查出宽度文本高亮
vim.opt.scrolloff = 8 -- 光标上下保持的最小行数
vim.opt.hlsearch = true -- 高亮搜索结果
vim.opt.incsearch = true -- 搜索实时高亮
vim.opt.inccommand = "split" -- 命令预览
vim.opt.ignorecase = false -- 搜索时是否忽略大小写
vim.opt.smartcase = true -- 智能大小写

vim.opt.splitright = true -- 在右侧分割新窗口
vim.opt.splitbelow = true -- 在下方分割新窗口

-- 编辑行为
vim.opt.tabstop = 2 -- Tab 宽度（Tab 字符显示的空格数）
vim.opt.softtabstop = 2 -- 编辑时 Tab 的宽度
vim.opt.shiftwidth = 2 -- 自动缩进宽度
vim.opt.expandtab = true -- 将 Tab 转为空格
vim.opt.autoindent = true -- 自动缩进
vim.opt.smartindent = true -- 智能缩进
vim.opt.breakindent = true -- 换行时保持缩进
vim.opt.wrap = false -- 自动换行
vim.opt.textwidth = 0 -- 文本宽度(0 表示不自动换行)
vim.opt.backspace = { "indent", "eol", "start" } -- Backspace 键行为

-- 性能优化
vim.opt.isfname:append("@-@") -- 设置识别文件名有 @ 符号的文件
vim.opt.updatetime = 50 -- 设置更新时间(毫秒)
vim.g.editorconfig = true -- 编码风格 - 可以使用项目 editorconfig 配置

-- 文件与缓冲区
vim.opt.encoding = "utf-8" -- 文件编码
vim.opt.fileencoding = "utf-8"
vim.opt.backup = false -- 不创建备份文件
vim.opt.writebackup = false -- 保存时不创建备份
vim.opt.swapfile = false -- 不创建交换文件
vim.opt.undofile = true -- 持久化 undo 历史

-- 启用 biome Mason也需要安装
vim.lsp.enable("biome")

-- 适配 Neovide
if vim.g.neovide then
	local alpha = function()
		return string.format("%x", math.floor(255 * (vim.g.transparency or 0.8)))
	end
	vim.g.neovide_opacity = 0.1
	vim.g.transparency = 0.6
	vim.g.neovide_background_color = "#0f1117" .. alpha()
	vim.g.neovide_cursor_vfx_mode = "railgun"
end
