return {
	{ "nvim-mini/mini.nvim", version = false },
	{ "nvim-mini/mini.icons", version = "*" },
	{
		"nvim-mini/mini.surround",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			custom_surroundings = nil,

			highlight_duration = 300,
			mappings = {
				add = "sa", -- Add surrounding in Normal and Visual modes
				delete = "ds", -- Delete surrounding
				find = "sf", -- Find surrounding (to the right)
				find_left = "sF", -- Find surrounding (to the left)
				highlight = "sh", -- Highlight surrounding
				replace = "sr", -- Replace surrounding
				update_n_lines = "sn", -- Update `n_lines`

				-- suffix_last = "l", -- Suffix to search with "prev" method
				-- suffix_next = "n", -- Suffix to search with "next" method
			},

			n_lines = 20,
			respect_selection_type = false,
			search_method = "cover",
			silent = false,
		},
	},
}
