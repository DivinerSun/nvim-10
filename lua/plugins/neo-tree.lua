require('neo-tree').setup({
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
      ["<space>"] = { "toggle_node", nowait = false, },
      ["<2-LeftMouse>"] = "open",
      ["<cr>"] = "open",
      ["l"] = "open",
      ["<esc>"] = "cancel",
    },
	},
  nesting_rules = require('neotree-file-nesting-config').nesting_rules,
})

vim.keymap.set("n", "<leader>e", "<Cmd>Neotree toggle reveal<CR>", { desc = "Toggle File Tree" })
