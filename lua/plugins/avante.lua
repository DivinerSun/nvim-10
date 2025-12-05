return {
	{
		"yetone/avante.nvim",
		build = vim.fn.has("win32") ~= 0
				and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
			or "make",
		event = "VeryLazy",
		version = false,
		opts = {
			instructions_file = "avante.md",
			provider = "qianwen",
			providers = {
				qianwen = {
					__inherited_from = "openai",
					api_key_name = "QIANWEN_NEOVIM_API_KEY",
					endpoint = "https://dashscope.aliyuncs.com/compatible-mode/v1",
					model = "qwen-coder-plus-latest",
				},
			},
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-mini/mini.pick",
			"nvim-telescope/telescope.nvim",
			"hrsh7th/nvim-cmp",
			"ibhagwan/fzf-lua",
			"stevearc/dressing.nvim",
			"folke/snacks.nvim",
			"nvim-tree/nvim-web-devicons",
			"zbirenbaum/copilot.lua",
			{
				-- brew install pngpaste
				"HakonHarnes/img-clip.nvim",
				event = "VeryLazy",
				opts = {
					default = {
						-- file and directory options
						dir_path = "images",
						extension = "png",
						file_name = "%Y-%m-%d-%H-%M-%S",
						use_absolute_path = false,
						relative_to_current_file = false,

						-- logging options
						verbose = true,

						-- template options
						template = "$FILE_PATH",
						url_encode_path = true,
						relative_template_path = true,
						use_cursor_in_template = true,
						insert_mode_after_paste = true,
						insert_template_after_cursor = true,

						-- prompt options
						prompt_for_file_name = true,
						show_dir_path_in_prompt = true,

						-- base64 options
						max_base64_size = 10,
						embed_image_as_base64 = false,

						-- image options
						process_cmd = "",
						copy_images = true,
						download_images = true,
						formats = { "jpeg", "jpg", "png" },

						-- drag and drop options
						drag_and_drop = {
							enabled = true,
							insert_mode = true,
							copy_images = true,
							download_images = true,
						},
					},
				},
				keys = {
					{
						"<leader>pi",
						"<cmd>PasteImage<CR>",
						desc = "Paste Image",
					},
				},
			},
		},
	},
}
