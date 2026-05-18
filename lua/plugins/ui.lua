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
			{ "<leader>n", group = " Notify", icon = "󱅰 " },
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

local Snacks = require("snacks")
Snacks.setup({
	bigfile = { enabled = true },
	dashboard = {
		enabled = true,
		preset = {
			header = [[
          ==================================================================================================
          ||   /$$$$$$$  /$$            /$$                              /$$ /$$    /$$ /$$               ||
          ||  | $$__  $$|__/           |__/                             | $/| $$   | $$|__/               ||
          ||  | $$  \ $$ /$$ /$$    /$$ /$$ /$$$$$$$   /$$$$$$   /$$$$$$|_/ | $$   | $$ /$$ /$$$$$$/$$$$  ||
          ||  | $$  | $$| $$|  $$  /$$/| $$| $$__  $$ /$$__  $$ /$$__  $$   |  $$ / $$/| $$| $$_  $$_  $$ ||
          ||  | $$  | $$| $$ \  $$/$$/ | $$| $$  \ $$| $$$$$$$$| $$  \__/    \  $$ $$/ | $$| $$ \ $$ \ $$ ||
          ||  | $$  | $$| $$  \  $$$/  | $$| $$  | $$| $$_____/| $$           \  $$$/  | $$| $$ | $$ | $$ ||
          ||  | $$$$$$$/| $$   \  $/   | $$| $$  | $$|  $$$$$$$| $$            \  $/   | $$| $$ | $$ | $$ ||
          ||  |_______/ |__/    \_/    |__/|__/  |__/ \_______/|__/             \_/    |__/|__/ |__/ |__/ ||
          ==================================================================================================
        ]],
			keys = {
				{ icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
				{ icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
				{
					icon = " ",
					key = "g",
					desc = "Find Text",
					action = ":lua Snacks.dashboard.pick('live_grep')",
				},
				{
					icon = " ",
					key = "r",
					desc = "Recent Files",
					action = ":lua Snacks.dashboard.pick('oldfiles')",
				},
				{
					icon = " ",
					key = "c",
					desc = "Config",
					action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
				},
				{ icon = " ", key = "s", desc = "Restore Session", section = "session" },
				-- { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
				{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
			},
		},
		sections = {
			{ section = "header", padding = { 2, 1 } },
			{ section = "keys", gap = 1, padding = 0 },
			-- { section = "startup" },
		},
	},
	explorer = { enabled = false },
	indent = { enabled = true },
	input = { enabled = true },
	notifier = {
		enabled = false,
		timeout = 3000,
	},
	picker = { enabled = true },
	quickfile = { enabled = true },
	scope = { enabled = true },
	scroll = { enabled = true },
	statuscolumn = { enabled = true },
	words = { enabled = true },
	styles = {
		notification = {
			wo = { wrap = true }, -- Wrap notifications
		},
	},
})

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

local incline = require("incline")
local helpers = require("incline.helpers")
local devicons = require("nvim-web-devicons")
local navic = require("nvim-navic")

navic.setup()
incline.setup({
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
		local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
		if filename == "" then
			filename = "[No Name]"
		end
		local ft_icon, ft_color = devicons.get_icon_color(filename)
		local modified = vim.bo[props.buf].modified

		local function get_git_diff()
			local icons_git = {
				added = " ",
				modified = " ",
				changed = " ",
				removed = " ",
				branch = "󱓎",
			}
			local signs = vim.b[props.buf].gitsigns_status_dict
			local labels = {}
			if signs == nil then
				return labels
			end
			for name, icon in pairs(icons_git) do
				if tonumber(signs[name]) and signs[name] > 0 then
					table.insert(labels, { " " .. icon .. " " .. signs[name] .. " ", group = "Diff" .. name })
				end
			end
			if #labels > 0 then
				table.insert(labels, { "┊ " })
			end
			return labels
		end

		local function get_diagnostic_label()
			local icons_d = {
				error = " ",
				warn = " ",
				info = " ",
				hint = " ",
			}
			local label = {}

			for severity, icon in pairs(icons_d) do
				local n = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity[string.upper(severity)] })
				if n > 0 then
					table.insert(label, { " " .. icon .. " " .. n .. " ", group = "DiagnosticSign" .. severity })
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
			ft_icon and { " ", ft_icon, " ", guibg = ft_color, guifg = helpers.contrast_color(ft_color) }
				or { " ", guifg = ft_color, guibg = "none" },
			{ " " .. filename .. " ", gui = modified and "bold,italic" or "bold", guibg = ft_color },
			{ "┊  " .. vim.api.nvim_win_get_number(props.win), group = "DevIconWindows" },
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
