return {
-- 文件树插件
{
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    lazy = false,
    config = function()
			vim.keymap.set("n", "<leader>e", "<Cmd>Neotree toggle reveal<CR>", { desc = "Toggle File Tree" })
			require("neo-tree").setup({
				enable_git_status = true,
				enable_diagnostics = true,
				sources = { "filesystem", "buffers", "git_status", "document_symbols" },
				open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" }, -- when opening files, do not use windows containing these filetypes or buftypes
				window = {
					position = "float",
					width = 80,
					mapping_options = {
						noremap = true,
						nowait = true,
					},
					mappings = {
						["<space>"] = {
							"toggle_node",
							nowait = false,
						},
						["<2-LeftMouse>"] = "open",
						["<cr>"] = "open",
						["l"] = "open",
						["<esc>"] = "cancel",
					},
				},
			})
		end,
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
			start_in_insert = true,
			insert_mappings = true,
			persist_size = true,
			direction = "float",
			close_on_exit = true,
			shell = vim.o.shell,
			float_opts = {
				border = "curved",
				winblend = 0,
				highlights = {
					border = "Normal",
					background = "Normal",
				},
			},
		},
	},
  -- Session 操作插件
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {},
    keys = {
      { "<leader>qs", function() require("persistence").load() end, desc = "Restore Session" },
      { "<leader>qS", function() require("persistence").select() end,desc = "Select Session" },
      { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      { "<leader>qd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
    },
  },
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
				["<BS>"] = "󰁮 ",
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
}
