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
