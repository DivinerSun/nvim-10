return {
	-- 多光标
	{
		"mg979/vim-visual-multi",
		event = "BufWinEnter",
	},
	-- Nvim 内部显示按键
	{
		"DivinerSun/showkeys",
		cmd = "ShowkeysToggle",
		init = function()
			-- 默认设置显示
			vim.cmd("ShowkeysToggle")
		end,
		keys = {
			{
				"<leader>k",
				function()
					vim.cmd("ShowkeysToggle")
				end,
				desc = "Toggle Showkeys",
			},
		},
		opts = {
			winopts = {
				-- focusable = false,
				relative = "editor",
				style = "minimal",
				border = "single",
				height = 1,
				row = 1,
				col = 0,
				zindex = 100,
			},

			winhl = "FloatBorder:Comment,Normal:Normal",

			timeout = 3, -- in secs
			maxkeys = 5,
			show_count = false,
			excluded_modes = { "i" },
			-- bottom-left, bottom-right, bottom-center, top-left, top-right, top-center
			position = "bottom-right",

			keyformat = {
				["<BS>"] = "",
				["<CR>"] = "󰘌",
				["<Space>"] = "󱁐",
				["<Up>"] = "󰁝",
				["<Down>"] = "󰁅",
				["<Left>"] = "󰁍",
				["<Right>"] = "󰁔",
				["<PageUp>"] = "Page 󰁝",
				["<PageDown>"] = "Page 󰁅",
				["<M>"] = "Alt",
				["<C>"] = "Ctrl",
			},
		},
	},
	-- 内部终端
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		opts = {
			size = 20,
			open_mapping = [[<C-t>]],
			hide_numbers = true,
			shade_filetypes = {},
			shade_terminals = true,
			shading_factor = 2,
			shading_ratio = 6,
			start_in_insert = true,
			insert_mappings = true,
			persist_size = true,
			persist_mode = true,
			direction = "float",
			close_on_exit = true,
			shell = vim.o.shell,
			auto_scroll = true,
			float_opts = {
				border = "curved", -- 'single' | 'double' | 'shadow' | 'curved'
				winblend = 3,
				zindex = 99,
				title_pos = "center",
			},
		},
	},
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
	-- 颜色插件
	{
		"catgoose/nvim-colorizer.lua",
		event = "BufReadPre",
		dependi = {
			{
				"roobert/tailwindcss-colorizer-cmp.nvim",
				config = function()
					require("tailwindcss-colorizer-cmp").setup({
						color_square_width = 2,
					})
				end,
			},
		},
		opts = {
			filetypes = { "*" },
			buftypes = {},
			user_commands = true,
			lazy_load = false,
			user_default_options = {
				names = true,
				names_opts = {
					lowercase = true,
					camelcase = true,
					uppercase = false,
					strip_digits = false,
				},
				names_custom = false,
				RGB = true,
				RGBA = true,
				RRGGBB = true,
				RRGGBBAA = true,
				AARRGGBB = true,
				rgb_fn = true,
				hsl_fn = true,
				oklch_fn = true,
				css = true,
				css_fn = true,
				tailwind = true,
				tailwind_opts = {
					update_names = false,
				},
				sass = { enable = true, parsers = { "css" } },
				mode = "background",
			},
		},
	},
	{
		"folke/trouble.nvim",
		cmd = "Trouble",
		opts = {},
	},
	{
		"nvim-telescope/telescope.nvim",
		version = "*",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		opts = function()
			local actions = require("telescope.actions")
			return {
				defaults = {
					mappings = {
						i = {
							["<C-j>"] = actions.move_selection_next,
							["<C-k>"] = actions.move_selection_previous,
							["<C-l>"] = actions.preview_scrolling_right,
							["<C-h>"] = actions.preview_scrolling_left,
						},
					},
				},
			}
		end,
	},
	{
		"ibhagwan/fzf-lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {},
	},
	{
		"folke/todo-comments.nvim",
		cmd = { "TodoTrouble", "TodoTelescope" },
		event = { "BufReadPre", "BufNewFile" },
		opts = {},
		keys = {
			{
				"]t",
				function()
					require("todo-comments").jump_next()
				end,
				desc = "Next Todo Comment",
			},
			{
				"[t",
				function()
					require("todo-comments").jump_prev()
				end,
				desc = "Previous Todo Comment",
			},
			{ "<leader>xt", "<cmd>Trouble todo toggle<cr>", desc = "Todo (Trouble)" },
			{
				"<leader>xT",
				"<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>",
				desc = "Todo/Fix/Fixme (Trouble)",
			},
			{ "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo" },
			{ "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
		},
	},
	-- 计时器
	{
		"nvzone/timerly",
		dependencies = "nvzone/volt",
		cmd = "TimerlyToggle",
		opts = function()
			vim.api.nvim_create_user_command("Timer", function()
				vim.o.showtabline = 0
				vim.o.laststatus = 0
				vim.wo.number = false
				vim.o.scl = "no"
				vim.o.cmdheight = 0
				vim.cmd("TimerlyToggle")
			end, {})
		end,
	},
}
