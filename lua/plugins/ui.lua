return {
	-- Git 插件
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			current_line_blame = true,
			current_line_blame_opts = {
				virt_text = true,
				virt_text_pos = "eol",
				delay = 1000,
				ignore_whitespace = false,
			},
			current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
		},
	},
	-- LSP 信息多行显示
	{
		-- "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		"DivinerSun/lsp_lines.nvim",
		config = function()
			local icons = require("utils.icons").diagnostics

			vim.diagnostic.config({
				virtual_text = {
					spacing = 4,
					prefix = "●",
					severity = {
						min = vim.diagnostic.severity.HINT,
					},
				},
				virtual_lines = false, -- 默认关闭多行，按 <A-i> 切换
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = icons.Error,
						[vim.diagnostic.severity.WARN] = icons.Warn,
						[vim.diagnostic.severity.INFO] = icons.Info,
						[vim.diagnostic.severity.HINT] = icons.Hint,
					},
				}, -- ⭐ 显示符号列图标
				underline = true, -- ⭐ 下划线
				update_in_insert = false,
				severity_sort = true, -- ⭐ 按严重程度排序
				float = {
					border = "rounded",
					source = true,
					header = "",
					prefix = "",
				},
			})

			-- 切换多行显示LSP错误信息
			vim.keymap.set("", "<A-i>", require("lsp_lines").toggle, { desc = "Toggle lsp_lines" })

			require("lsp_lines").setup()
		end,
	},
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
				extensions = { "neo-tree", "lazy" },
			}
		end,
	},
	-- 配置 IncLine 导航
	{
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
								table.insert(
									labels,
									{ " " .. icon .. " " .. signs[name] .. " ", group = "Diff" .. name }
								)
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
						{ (ft_icon or "") .. " ", guifg = ft_color, guibg = "none" },
						{ filename, gui = modified and "bold,italic" or "bold" },
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
	},
	-- 缩进线
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		config = function()
			local highlight = {
				"RainbowRed",
				"RainbowYellow",
				"RainbowBlue",
				"RainbowOrange",
				"RainbowGreen",
				"RainbowViolet",
				"RainbowCyan",
			}

			local hooks = require("ibl.hooks")

			hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
				vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
				vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
				vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
				vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
				vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
				vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
				vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
			end)
			hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)

			-- require("ibl").setup({ indent = { highlight = highlight }, scope = { highlight = highlight } })
			require("ibl").setup({ scope = { highlight = highlight } })
		end,
	},
}
