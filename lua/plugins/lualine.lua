return {
  -- 自定义底部状态栏
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = function()
			vim.o.laststatus = vim.g.lualine_laststatus

			local icons = require("utils.icons")

			local conditions = {
				buffer_not_empty = function()
					return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
				end,
				hide_in_width = function()
					return vim.fn.winwidth(0) > 80
				end,
				check_git_workspace = function()
					local filepath = vim.fn.expand("%:p:h")
					local gitdir = vim.fn.finddir(".git", filepath .. ";")
					return gitdir and #gitdir > 0 and #gitdir < #filepath
				end,
			}

			local diagnostics = {
				"diagnostics",
				symbols = {
					error = icons.diagnostics.Error .. " ",
					warn = icons.diagnostics.Warn .. " ",
					info = icons.diagnostics.Info .. " ",
					hint = icons.diagnostics.Hint .. " ",
				},
				colored = true,
				update_in_insert = false,
				always_visible = false,
			}

			local diff = {
				"diff",
				symbols = {
					added = icons.git.Added .. " ",
					modified = icons.git.Modified .. " ",
					removed = icons.git.Removed .. " ",
				},
				source = function()
					local gitsigns = vim.b.gitsigns_status_dict
					if gitsigns then
						return {
							added = gitsigns.added,
							modified = gitsigns.changed,
							removed = gitsigns.removed,
						}
					end
				end,
			}

			local mode = {
				"mode",
				fmt = function(str)
					return "--" .. str .. "--"
				end,
			}

			local branch = {
				"branch",
				icons_enabled = true,
				icon = icons.git.Branch,
			}

			local location = {
				"location",
				padding = 1,
				color = { fg = "#FFFFFF", bg = "#d86079" },
			}

			-- cool function for progress
			local progress = function()
				local current_line = vim.fn.line(".")
				local total_lines = vim.fn.line("$")
				local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
				local line_ratio = current_line / total_lines
				local index = math.ceil(line_ratio * #chars)
				return chars[index] .. " " .. math.floor(line_ratio * 100)
			end

			local spaces = function()
				return icons.ui.Tab .. " " .. vim.api.nvim_get_option_value("shiftwidth", {})
			end

			local file_name = {
				"filename",
				cond = conditions.buffer_not_empty,
			}

			return {
				options = {
					theme = "auto",
					globalstatus = true,
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },
					disabled_filetypes = {
						"TelescopePrompt",
						"packer",
						"alpha",
						"dashboard",
						"NvimTree",
						"Outline",
						"DressingInput",
						"toggleterm",
						"lazy",
						"mason",
						statusline = { "dashboard", "alpha", "starter" },
					},
					refresh = {
						statusline = 100,
						tabline = 100,
						winbar = 100,
						refresh_time = 16, -- ~60fps
						events = {
							"WinEnter",
							"BufEnter",
							"BufWritePost",
							"SessionLoadPost",
							"FileChangedShellPost",
							"VimResized",
							"Filetype",
							"CursorMoved",
							"CursorMovedI",
							"ModeChanged",
						},
					},
					icons_enabled = true,
					always_divide_middle = true,
					always_show_tabline = true,
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
					lualine_b = { mode, branch },
					lualine_c = { diagnostics, diff },
					lualine_x = {
						"lsp_status",
						spaces,
						"encoding",
						"filesize",
					},
					lualine_y = { location },
					lualine_z = { { progress, color = { fg = "#FF99CC" } } },
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { file_name },
					lualine_x = { "location" },
					lualine_y = {},
					lualine_z = {},
				},
				tabline = {},
				extensions = { "neo-tree", "lazy", "fzf" },
			}
		end,
	},
}
