return {
	"b0o/incline.nvim",
	dependencies = {
		{
			"SmiteshP/nvim-navic",
			dependencies = "neovim/nvim-lspconfig",
		},
	},
	opts = function()
		local opts = {
			highlight = {
				groups = {
					InclineNormal = { guibg = "#822455" },
				},
			},
			window = {
				padding = 0,
				margin = {
					horizontal = 0,
					vertical = 0,
				},
			},
			debounce_threshold = { falling = 500, rising = 250 },
			render = function(props)
				local helpers = require("incline.helpers")
				local devicons = require("nvim-web-devicons")
				local navic = require("nvim-navic")

				local icons = require("utils.icons")

				local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
				if filename == "" then
					filename = "[No Name]"
				end
				local ft_icon, ft_color = devicons.get_icon_color(filename)
				local modified = vim.bo[props.buf].modified

				local function get_git_diff()
					local icons_git = {
						added = icons.git.Added,
						changed = icons.git.Modified,
						removed = icons.git.Removed,
					}
					local signs = vim.b[props.buf].gitsigns_status_dict
					local labels = {}
					if signs == nil then
						return labels
					end
					for name, icon in pairs(icons_git) do
						if tonumber(signs[name]) and signs[name] > 0 then
							table.insert(labels, { " " .. icon .. " " .. signs[name] .. " ", group = "Diff" .. name })
						end
					end
					if #labels > 0 then
						table.insert(labels, { "┊ " })
					end
					return labels
				end

				local function get_diagnostic_label()
					local icons_d = {
						error = icons.diagnostics.Error,
						warn = icons.diagnostics.Warn,
						info = icons.diagnostics.Info,
						hint = icons.diagnostics.Hint,
					}
					local label = {}

					for severity, icon in pairs(icons_d) do
						local n = #vim.diagnostic.get(
							props.buf,
							{ severity = vim.diagnostic.severity[string.upper(severity)] }
						)
						if n > 0 then
							table.insert(
								label,
								{ " " .. icon .. " " .. n .. " ", group = "DiagnosticSign" .. severity }
							)
						end
					end
					if #label > 0 then
						table.insert(label, { "┊ " })
					end

					return label
				end

				local res = {
					{ get_diagnostic_label() },
					{ get_git_diff() },
					ft_icon and { " ", ft_icon, " ", guibg = ft_color, guifg = helpers.contrast_color(ft_color) }
						or { " ", guifg = ft_color, guibg = "none" },
					{ " " .. filename, gui = modified and "bold,italic" or "bold" },
					{ " ┊  " .. vim.api.nvim_win_get_number(props.win), group = "DevIconWindows" },
					guibg = "#44406e",
				}

				if props.focused then
					for _, item in ipairs(navic.get_data(props.buf) or {}) do
						table.insert(res, {
							{ " > ", group = "NavicSeparator" },
							{ item.icon, group = "NavicIcons" .. item.type },
							{ item.name, group = "NavicText" },
						})
					end
				end
				table.insert(res, " ")
				return res
			end,
		}
		return opts
	end,
}
