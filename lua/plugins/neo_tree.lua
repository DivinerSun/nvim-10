require("neo-tree").setup({
	close_if_last_window = true,
	enable_git_status = true,
	enable_diagnostics = true,
	popup_border_style = "rounded",
	hide_root_node = true,
	retain_hidden_root_indent = true,
	default_component_configs = {
		indent = {
			with_expanders = true,
		},
	},
	window = {
		position = "float",
		popup = {
			size = {
				height = "80%",
				width = "50%",
			},
			position = "50%",
		},
		mappings = {
			["<space>"] = { "toggle_node", nowait = false },
			["<2-LeftMouse>"] = "open",
			["<cr>"] = "open",
			["l"] = "open",
			["<esc>"] = "cancel",
		},
	},
	filesystem = {
		follow_current_file = {
			enabled = true,
		},
		use_libuv_file_watcher = true,
		filtered_items = {
			visible = false,
			hide_dotfiles = true,
			hide_gitignored = true,
			hide_ignored = true,
			hide_by_name = {
				".DS_Store",
				"thumbs.db",
				"node_modules",
				"dist",
				"build",
				"target",
				"coverage",
				".cache",
				".next",
				".nuxt",
				".output",
				".turbo",
			},
		},
		window = {
			position = "float",
		},
	},
	nesting_rules = require("neotree-file-nesting-config").nesting_rules,
})

-- 全局：打开/切换 neo-tree
vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle filesystem reveal float<CR>", {
	desc = "Toggle file explorer",
	silent = true,
})
