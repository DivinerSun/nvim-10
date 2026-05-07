return {
	-- Lua
	{
		"folke/lazydev.nvim",
		ft = "lua",
		cmd = "LazyDev",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				{ path = "LazyVim", words = { "LazyVim" } },
				{ path = "snacks.nvim", words = { "Snacks" } },
				{ path = "lazy.nvim", words = { "LazyVim" } },
			},
		},
	},
	-- Rust
	{
		"mrcjkb/rustaceanvim",
		version = "^9",
		lazy = false,
	},
	{
		"saecki/crates.nvim",
		tag = "stable",
		config = function()
			require("crates").setup({})
		end,
	},
	-- Emmet
	{
		"mattn/emmet-vim",
		ft = {
			"astro",
			"html",
			"javascriptreact",
			"svelte",
			"typescriptreact",
			"vue",
		},
		init = function()
			vim.g.user_emmet_install_global = 0
			vim.g.user_emmet_mode = "inv"
			vim.g.user_emmet_expandabbr_key = "<C-e>"
			vim.g.user_emmet_settings = {
				astro = { extends = "html" },
				javascriptreact = { extends = "jsx" },
				typescriptreact = { extends = "jsx" },
				vue = { extends = "html" },
			}
		end,
		config = function()
			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("emmet_install", { clear = true }),
				pattern = {
					"astro",
					"html",
					"javascriptreact",
					"svelte",
					"typescriptreact",
					"vue",
				},
				command = "EmmetInstall",
			})
		end,
	},
	-- Markdown
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
}
