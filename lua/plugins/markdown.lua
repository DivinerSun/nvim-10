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

require("render-markdown").setup({
	file_types = { "markdown", "vimwiki", "Avante" },
	heading = {
		enabled = true,
		sign = true,
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
		enabled = true,
		sign = true,
		width = "full",
		right_pad = 1,
		border = "thick",
	},
	bullet = {
		enabled = true,
		icons = { "●", "○", "◆", "◇" },
	},
	checkbox = {
		enabled = true,
		unchecked = {
			icon = "󰄗 ",
			highlight = "RenderMarkdownUnchecked",
			scope_highlight = nil,
		},
		checked = {
			icon = "󰄵 ",
			highlight = "RenderMarkdownChecked",
			scope_highlight = nil,
		},
	},
	quote = {
		enabled = true,
		render_modes = false,
		icon = "▋",
		repeat_linebreak = false,
		highlight = {
			"RenderMarkdownQuote1",
			"RenderMarkdownQuote2",
			"RenderMarkdownQuote3",
			"RenderMarkdownQuote4",
			"RenderMarkdownQuote5",
			"RenderMarkdownQuote6",
		},
	},
	pipe_table = {
		enabled = true,
		render_modes = false,
		preset = "round",
		cell = "padded",
		cell_offset = function()
			return 0
		end,
		padding = 1,
		min_width = 0,
		border = {
			"┌",
			"┬",
			"┐",
			"├",
			"┼",
			"┤",
			"└",
			"┴",
			"┘",
			"│",
			"─",
		},
		border_enabled = true,
		border_virtual = false,
		alignment_indicator = "━",
		head = "RenderMarkdownTableHead",
		row = "RenderMarkdownTableRow",
		style = "full",
	},
	callout = {
		note = {
			raw = "[!NOTE]",
			rendered = "󰋽 Note",
			highlight = "RenderMarkdownInfo",
			category = "github",
		},
		tip = {
			raw = "[!TIP]",
			rendered = "󰌶 Tip",
			highlight = "RenderMarkdownSuccess",
			category = "github",
		},
		important = {
			raw = "[!IMPORTANT]",
			rendered = "󰅾 Important",
			highlight = "RenderMarkdownHint",
			category = "github",
		},
		warning = {
			raw = "[!WARNING]",
			rendered = "󰀪 Warning",
			highlight = "RenderMarkdownWarn",
			category = "github",
		},
		caution = {
			raw = "[!CAUTION]",
			rendered = "󰳦 Caution",
			highlight = "RenderMarkdownError",
			category = "github",
		},
		abstract = {
			raw = "[!ABSTRACT]",
			rendered = "󰨸 Abstract",
			highlight = "RenderMarkdownInfo",
			category = "obsidian",
		},
		summary = {
			raw = "[!SUMMARY]",
			rendered = "󰨸 Summary",
			highlight = "RenderMarkdownInfo",
			category = "obsidian",
		},
		tldr = {
			raw = "[!TLDR]",
			rendered = "󰨸 Tldr",
			highlight = "RenderMarkdownInfo",
			category = "obsidian",
		},
		info = {
			raw = "[!INFO]",
			rendered = "󰋽 Info",
			highlight = "RenderMarkdownInfo",
			category = "obsidian",
		},
		todo = {
			raw = "[!TODO]",
			rendered = "󰗡 Todo",
			highlight = "RenderMarkdownInfo",
			category = "obsidian",
		},
		hint = {
			raw = "[!HINT]",
			rendered = "󰌶 Hint",
			highlight = "RenderMarkdownSuccess",
			category = "obsidian",
		},
		success = {
			raw = "[!SUCCESS]",
			rendered = "󰄬 Success",
			highlight = "RenderMarkdownSuccess",
			category = "obsidian",
		},
		check = {
			raw = "[!CHECK]",
			rendered = "󰄬 Check",
			highlight = "RenderMarkdownSuccess",
			category = "obsidian",
		},
		done = {
			raw = "[!DONE]",
			rendered = "󰄬 Done",
			highlight = "RenderMarkdownSuccess",
			category = "obsidian",
		},
		question = {
			raw = "[!QUESTION]",
			rendered = "󰘥 Question",
			highlight = "RenderMarkdownWarn",
			category = "obsidian",
		},
		help = {
			raw = "[!HELP]",
			rendered = "󰘥 Help",
			highlight = "RenderMarkdownWarn",
			category = "obsidian",
		},
		faq = {
			raw = "[!FAQ]",
			rendered = "󰘥 Faq",
			highlight = "RenderMarkdownWarn",
			category = "obsidian",
		},
		attention = {
			raw = "[!ATTENTION]",
			rendered = "󰀪 Attention",
			highlight = "RenderMarkdownWarn",
			category = "obsidian",
		},
		failure = {
			raw = "[!FAILURE]",
			rendered = "󰅖 Failure",
			highlight = "RenderMarkdownError",
			category = "obsidian",
		},
		fail = {
			raw = "[!FAIL]",
			rendered = "󰅖 Fail",
			highlight = "RenderMarkdownError",
			category = "obsidian",
		},
		missing = {
			raw = "[!MISSING]",
			rendered = "󰅖 Missing",
			highlight = "RenderMarkdownError",
			category = "obsidian",
		},
		danger = {
			raw = "[!DANGER]",
			rendered = "󱐌 Danger",
			highlight = "RenderMarkdownError",
			category = "obsidian",
		},
		error = {
			raw = "[!ERROR]",
			rendered = "󱐌 Error",
			highlight = "RenderMarkdownError",
			category = "obsidian",
		},
		bug = {
			raw = "[!BUG]",
			rendered = "󰨰 Bug",
			highlight = "RenderMarkdownError",
			category = "obsidian",
		},
		example = {
			raw = "[!EXAMPLE]",
			rendered = "󰉹 Example",
			highlight = "RenderMarkdownHint",
			category = "obsidian",
		},
		quote = {
			raw = "[!QUOTE]",
			rendered = "󱆨 Quote",
			highlight = "RenderMarkdownQuote",
			category = "obsidian",
		},
		cite = {
			raw = "[!CITE]",
			rendered = "󱆨 Cite",
			highlight = "RenderMarkdownQuote",
			category = "obsidian",
		},
	},
	link = {
		enabled = true,
		render_modes = false,
		footnote = {
			enabled = true,
			icon = "󰯔 ",
			body = function(ctx)
				return ctx.text
			end,
			superscript = true,
			prefix = "",
			suffix = "",
		},
		image = "󰥶 ",
		image_custom = true,
		email = "󰻣 ",
		hyperlink = "󰌹 ",
		highlight = "RenderMarkdownLink",
		highlight_title = "RenderMarkdownLinkTitle",
		wiki = {
			enabled = true,
			icon = "󱗖 ",
			conceal_destination = true,
			body = function()
				return nil
			end,
			highlight = "RenderMarkdownWikiLink",
			scope_highlight = nil,
		},
		custom = {
			web = { icon = "󰖟 ", pattern = "^http" },
			apple = { icon = " ", pattern = "apple%.com", kind = "url" },
			discord = { icon = "󰙯 ", pattern = "discord%.com", kind = "url" },
			github = { icon = "󰊤 ", pattern = "github%.com", kind = "url" },
			gitlab = { icon = "󰮠 ", pattern = "gitlab%.com", kind = "url" },
			google = { icon = "󰊭 ", pattern = "google%.com", kind = "url" },
			hackernews = { icon = " ", pattern = "ycombinator%.com", kind = "url" },
			linkedin = { icon = "󰌻 ", pattern = "linkedin%.com", kind = "url" },
			microsoft = { icon = " ", pattern = "microsoft%.com", kind = "url" },
			neovim = { icon = " ", pattern = "neovim%.io", kind = "url" },
			reddit = { icon = "󰑍 ", pattern = "reddit%.com", kind = "url" },
			slack = { icon = "󰒱 ", pattern = "slack%.com", kind = "url" },
			stackoverflow = { icon = "󰓌 ", pattern = "stackoverflow%.com", kind = "url" },
			steam = { icon = " ", pattern = "steampowered%.com", kind = "url" },
			twitter = { icon = " ", pattern = "twitter%.com", kind = "url" },
			wikipedia = { icon = "󰖬 ", pattern = "wikipedia%.org", kind = "url" },
			x = { icon = " ", pattern = "x%.com", kind = "url" },
			youtube = { icon = "󰗃 ", pattern = "youtube[^.]*%.com", kind = "url" },
			youtube_short = { icon = "󰗃 ", pattern = "youtu%.be", kind = "url" },
			react = { icon = " ", pattern = "react%.dev", kind = "url" },
			next = { icon = " ", pattern = "nextjs%.org", kind = "url" },
			nest = { icon = " ", pattern = "nestjs%.com", kind = "url" },
			tailwindcss = { icon = " ", pattern = "tailwindcss%.com", kind = "url" },
			vue = { icon = " ", pattern = "vuejs%.org", kind = "url" },
			vite = { icon = " ", pattern = "vitejs%.dev", kind = "url" },
			rust = { icon = " ", pattern = "rust-lang%.org", kind = "url" },
		},
	},
	indent = {
		enabled = true,
		render_modes = false,
		per_level = 2,
		skip_level = 1,
		skip_heading = false,
		icon = "▎",
		priority = 0,
		highlight = "RenderMarkdownIndent",
	},
})
