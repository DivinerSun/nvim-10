require("which-key").setup()

require("lualine").setup({
	options = {
		theme = "catppuccin-mocha",
		globalstatus = true,
		section_separators = "",
		component_separators = "",
	},
	sections = {
		lualine_c = {
			{
				"filename",
				path = 1,
			},
		},
		lualine_x = {
			"encoding",
			"fileformat",
			"filetype",
		},
	},
})
