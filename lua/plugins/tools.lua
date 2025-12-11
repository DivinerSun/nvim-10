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
  }
}
