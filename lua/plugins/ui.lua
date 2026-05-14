require("which-key").setup()

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
