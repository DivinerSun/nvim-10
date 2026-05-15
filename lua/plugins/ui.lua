require("which-key").setup({
	preset = "helix",
	icons = { group = "" },
	spec = {
		{
			mode = { "n", "x" },
			-- { "<leader>a", group = "AICode", icon = " " },
			-- { "<leader>b", group = " Buffer", icon = " " },
			{ "<leader>c", group = " Codes", icon = " " },
			{ "<leader>d", group = " Debug", icon = " " },
			{ "<leader>f", group = " Find", icon = " " },
			{ "<leader>g", group = " Git", icon = " " },
			-- { "<leader>p", group = "Preview/Paste", icon = " " },
			{ "<leader>q", group = " Session", icon = " " },
			{ "<leader>s", group = " Split", icon = " " },
			{ "<leader>t", group = " Test", icon = "󰰦 " },
			-- { "<leader>u", group = " UI", icon = " " },
		},
	},
})
vim.keymap.set("n", "<leader>?", function()
	require("which-key").show({ global = false })
end, { desc = "Buffer Local KeyMaps" })

require("lualine").setup({
	options = {
		theme = "auto",
		globalstatus = true,
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
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
		lualine_x = {
			"encoding",
			"filetype",
			"filesize",
		},
	},
})

require("todo-comments").setup({})
vim.keymap.set("n", "]t", function()
	require("todo-comments").jump_next()
end, { desc = "Next Todo Comment" })
vim.keymap.set("n", "[t", function()
	require("todo-comments").jump_prev()
end, { desc = "Previous Todo Comment" })

require("showkeys").setup({
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
})
vim.cmd("ShowkeysToggle")
vim.keymap.set("n", "<leader>k", function()
	vim.cmd("ShowkeysToggle")
end, { desc = "Toggle Showkeys" })

require("toggleterm").setup({
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
})
