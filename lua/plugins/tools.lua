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
}

