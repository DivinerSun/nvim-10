return {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		init = function()
			local color1_bg = "#ff757f"
			local color2_bg = "#4fd6be"
			local color3_bg = "#7dcfff"
			local color4_bg = "#ff9e64"
			local color5_bg = "#7aa2f7"
			local color6_bg = "#c0caf5"
			local color_fg = "#1F2335"

			-- Heading background
			vim.cmd(string.format([[highlight Headline1Bg guifg=%s guibg=%s gui=bold]], color_fg, color1_bg))
			vim.cmd(string.format([[highlight Headline2Bg guifg=%s guibg=%s gui=bold]], color_fg, color2_bg))
			vim.cmd(string.format([[highlight Headline3Bg guifg=%s guibg=%s gui=bold]], color_fg, color3_bg))
			vim.cmd(string.format([[highlight Headline4Bg guifg=%s guibg=%s gui=bold]], color_fg, color4_bg))
			vim.cmd(string.format([[highlight Headline5Bg guifg=%s guibg=%s gui=bold]], color_fg, color5_bg))
			vim.cmd(string.format([[highlight Headline6Bg guifg=%s guibg=%s gui=bold]], color_fg, color6_bg))
		end,
		opts = {
			file_types = { "markdown", "Avante" },
			heading = {
				sign = false,
				backgrounds = {
					"Headline1Bg",
					"Headline2Bg",
					"Headline3Bg",
					"Headline4Bg",
					"Headline5Bg",
					"Headline6Bg",
				},
				foregrounds = {
					"Headline1Fg",
					"Headline2Fg",
					"Headline3Fg",
					"Headline4Fg",
					"Headline5Fg",
					"Headline6Fg",
				},
			},
			code = {
				sign = false,
				width = "block",
				right_pad = 1,
			},
			bullet = {
				enabled = true,
			},
			checkbox = {
				enabled = true,
				position = "inline", -- inline | overlay
			},
		},
		ft = { "markdown", "Avante" },
	},
	-- ⭐ Markdown 浏览器预览
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
		ft = { "markdown" },
		keys = {
			{
				"<leader>pm",
				"<cmd>MarkdownPreviewToggle<cr>",
				desc = "Markdown Preview",
			},
		},
		config = function()
			vim.g.mkdp_auto_start = 0
			vim.g.mkdp_auto_close = 1
			vim.g.mkdp_theme = "dark"
			vim.g.mkdp_page_title = "「${name}」"
		end,
	},
}
