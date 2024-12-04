return {
  -- 图标插件
  { "nvim-tree/nvim-web-devicons" },
  -- 自定义主题配置
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = {
      style = "moon",
      transparent = true,
      terminal_colors = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        functions = { italic = true },
        variables = {},
        sidebars = "transparent",
        floats = "transparent",
      },
      on_colors = function(C)
        C.comment = "#FF81D0"
        C.fg_gutter = "#813c85"

        return {
          Comment = { fg = C.pink },
          CmpItemMenu = { fg = C.pink, bg = C.None },
          CmpItemKindSnippet = { fg = C.base, bg = C.mauve },
          CmpItemKindKeyword = { fg = C.base, bg = C.red },
          CmpItemKindText = { fg = C.base, bg = C.lavender },
          CmpItemKindMethod = { fg = C.base, bg = C.blue },
          CmpItemKindConstructor = { fg = C.base, bg = C.blue },
          CmpItemKindFunction = { fg = C.base, bg = C.blue },
          CmpItemKindFolder = { fg = C.base, bg = C.blue },
          CmpItemKindModule = { fg = C.base, bg = C.blue },
          CmpItemKindConstant = { fg = C.base, bg = C.peach },
          CmpItemKindField = { fg = C.base, bg = C.green },
          CmpItemKindProperty = { fg = C.base, bg = C.green },
          CmpItemKindEnum = { fg = C.base, bg = C.green },
          CmpItemKindUnit = { fg = C.base, bg = C.green },
          CmpItemKindClass = { fg = C.base, bg = C.yellow },
          CmpItemKindVariable = { fg = C.base, bg = C.flamingo },
          CmpItemKindFile = { fg = C.base, bg = C.blue },
          CmpItemKindInterface = { fg = C.base, bg = C.yellow },
          CmpItemKindColor = { fg = C.base, bg = C.red },
          CmpItemKindReference = { fg = C.base, bg = C.red },
          CmpItemKindEnumMember = { fg = C.base, bg = C.red },
          CmpItemKindStruct = { fg = C.base, bg = C.blue },
          CmpItemKindValue = { fg = C.base, bg = C.peach },
          CmpItemKindEvent = { fg = C.base, bg = C.blue },
          CmpItemKindOperator = { fg = C.base, bg = C.blue },
          CmpItemKindTypeParameter = { fg = C.base, bg = C.blue },
          CmpItemKindCopilot = { fg = C.base, bg = C.teal },
          CmpItemKindCodeium = { fg = C.base, bg = C.teal },
        }
      end,
    },
  },
  -- 自定义Dashboard
  {
    "nvimdev/dashboard-nvim",
    lazy = false,
    opts = function()
      local logo = [[
        $$$$$$$\  $$\            $$\                             $$\ $$\    $$\ $$\               
        $$  __$$\ \__|           \__|                            $  |$$ |   $$ |\__|              
        $$ |  $$ |$$\ $$\    $$\ $$\ $$$$$$$\   $$$$$$\   $$$$$$\\_/ $$ |   $$ |$$\ $$$$$$\$$$$\  
        $$ |  $$ |$$ |\$$\  $$  |$$ |$$  __$$\ $$  __$$\ $$  __$$\   \$$\  $$  |$$ |$$  _$$  _$$\ 
        $$ |  $$ |$$ | \$$\$$  / $$ |$$ |  $$ |$$$$$$$$ |$$ |  \__|   \$$\$$  / $$ |$$ / $$ / $$ |
        $$ |  $$ |$$ |  \$$$  /  $$ |$$ |  $$ |$$   ____|$$ |          \$$$  /  $$ |$$ | $$ | $$ |
        $$$$$$$  |$$ |   \$  /   $$ |$$ |  $$ |\$$$$$$$\ $$ |           \$  /   $$ |$$ | $$ | $$ |
        \_______/ \__|    \_/    \__|\__|  \__| \_______|\__|            \_/    \__|\__| \__| \__|
      ]]
      logo = string.rep("\n", 6) .. logo .. "\n\n"

      local opts = {
        theme = "doom",
        hide = {
          statusline = false,
        },
        config = {
          header = vim.split(logo, "\n"),
          center = {
            {
              action = "lua LazyVim.pick()()",
              desc = " Find File",
              icon = " ",
              key = "f",
            },
            {
              action = "ene | startinsert",
              desc = " New File",
              icon = " ",
              key = "n",
            },
            {
              action = 'lua LazyVim.pick("oldfiles")()',
              desc = " Recent Files",
              icon = " ",
              key = "r",
            },
            {
              action = 'lua LazyVim.pick("live_grep")()',
              desc = " Find Text",
              icon = " ",
              key = "g",
            },
            {
              action = "lua LazyVim.pick.config_files()()",
              desc = " Config",
              icon = " ",
              key = "c",
            },
            {
              action = 'lua require("persistence").load()',
              desc = " Restore Session",
              icon = " ",
              key = "s",
            },
            {
              action = "LazyExtras",
              desc = " Lazy Extras",
              icon = " ",
              key = "x",
            },
            {
              action = "Lazy",
              desc = " Lazy",
              icon = "󰒲 ",
              key = "l",
            },
            {
              action = function()
                vim.api.nvim_input("<cmd>qa<cr>")
              end,
              desc = " Quit",
              icon = " ",
              key = "q",
            },
          },
          footer = function()
            local stats = require("lazy").stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
          end,
        },
      }

      for _, button in ipairs(opts.config.center) do
        button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
        button.key_format = "  %s"
      end

      -- open dashboard after closing lazy
      if vim.o.filetype == "lazy" then
        vim.api.nvim_create_autocmd("WinClosed", {
          pattern = tostring(vim.api.nvim_get_current_win()),
          once = true,
          callback = function()
            vim.schedule(function()
              vim.api.nvim_exec_autocmds("UIEnter", { group = "dashboard" })
            end)
          end,
        })
      end

      return opts
    end,
  },
  -- 自定义Neotree
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = "Neotree",
    keys = {},
    deactivate = function()
      vim.cmd([[Neotree close]])
    end,
    opts = {
      enable_git_status = true,
      enable_diagnostics = true,
      sources = { "filesystem", "buffers", "git_status", "document_symbols" },
      open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
      filesystem = {
        bind_to_cwd = false,
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
      },
      window = {
        position = "float",
        width = 40,
        mapping_options = {
          noremap = true,
          nowait = true,
        },
        mappings = {
          ["<space>"] = "none",
          ["<2-LeftMouse>"] = "open",
          ["<cr>"] = "open",
          ["l"] = "open",
          ["<esc>"] = "revert_preview",
          ["P"] = { "toggle_preview", config = { use_float = true } },
          ["S"] = "open_split",
          ["s"] = "open_vsplit",
          ["t"] = "open_tabnew",
          ["w"] = "open_with_window_picker",
          ["C"] = "close_node",
          ["h"] = "close_node",
          ["z"] = "close_all_nodes",
          ["Z"] = "expand_all_nodes",
          ["a"] = {
            "add",
            config = {
              show_path = "none",
            },
          },
          ["A"] = "add_directory",
          ["d"] = "delete",
          ["r"] = "rename",
          ["y"] = "copy_to_clipboard",
          ["x"] = "cut_to_clipboard",
          ["p"] = "paste_from_clipboard",
          ["c"] = "copy",
          ["m"] = "move",
          ["q"] = "close_window",
          ["R"] = "refresh",
          ["?"] = "show_help",
          ["<"] = "prev_source",
          [">"] = "next_source",
        },
      },
    },
  },
  -- 状态栏配置
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        always_show_bufferline = true,
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      vim.o.laststatus = vim.g.lualine_laststatus

      local icons = require("custom.icons")
      local hide_in_width = function()
        return vim.fn.winwidth(0) > 80
      end

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
        sources = { "nvim_diagnostic" },
        sections = { "error", "warn" },
        symbols = {
          error = icons.diagnostics.BoldError .. " ",
          warn = icons.diagnostics.BoldWarning .. " ",
        },
        colored = true,
        update_in_insert = false,
        always_visible = false,
      }

      local diff = {
        "diff",
        colored = true,
        symbols = {
          added = icons.git.LineAdded .. " ",
          modified = icons.git.LineModified .. " ",
          removed = icons.git.LineRemoved .. " ",
        },
        cond = hide_in_width,
      }

      local mode = {
        "mode",
        fmt = function(str)
          return "--" .. str .. "--"
        end,
      }

      local fileType = {
        "filetype",
        icons_enabled = true,
        icon = nil,
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
        return chars[index]
      end

      local spaces = function()
        return icons.ui.Tab .. " " .. vim.api.nvim_get_option_value("shiftwidth", {})
      end

      local file_name = {
        "filename",
        cond = conditions.buffer_not_empty,
      }

      -- start for lsp
      local list_registered_providers_names = function(filetype)
        local s = require("null-ls.sources")
        local available_sources = s.get_available(filetype)
        local registered = {}
        for _, source in ipairs(available_sources) do
          for method in pairs(source.methods) do
            registered[method] = registered[method] or {}
            table.insert(registered[method], source.name)
          end
        end
        return registered
      end

      local null_ls = require("null-ls")
      -- for formatter
      local list_registered = function(filetype)
        local method = null_ls.methods.FORMATTING
        local registered_providers = list_registered_providers_names(filetype)
        return registered_providers[method] or {}
      end

      --- for linter
      local alternative_methods = {
        null_ls.methods.DIAGNOSTICS,
        null_ls.methods.DIAGNOSTICS_ON_OPEN,
        null_ls.methods.DIAGNOSTICS_ON_SAVE,
      }

      local linter_list_registered = function(filetype)
        local registered_providers = list_registered_providers_names(filetype)
        local providers_for_methods = vim
          .iter(vim.tbl_map(function(m)
            return registered_providers[m] or {}
          end, alternative_methods))
          :flatten()
          :totable()

        return providers_for_methods
      end

      local lsp_info = {
        function()
          local msg = "[ LS Inactive ]"
          local buf_ft = vim.bo.filetype
          local buf_clients = vim.lsp.get_clients({ bufnr = 0 })
          local buf_client_names = {}
          if next(buf_clients) == nil then
            if type(msg) == "boolean" or #msg == 0 then
              return "[ LS Inactive ]"
            end
            return msg
          end
          for _, client in pairs(buf_clients) do
            if client.name ~= "null-ls" and client.name ~= "copilot" then
              table.insert(buf_client_names, client.name)
            end
          end
          local supported_formatters = list_registered(buf_ft)
          vim.list_extend(buf_client_names, supported_formatters)
          local supported_linters = linter_list_registered(buf_ft)
          vim.list_extend(buf_client_names, supported_linters)
          -- local unique_client_names = vim.fn.uniq(buf_client_names)
          msg = table.concat(buf_client_names, ", ")
          return "[" .. msg .. "]"
        end,
        icon = icons.ui.Fire .. "",
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
          icons_enabled = true,
          always_divide_middle = true,
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
            branch,
          },
          lualine_b = { mode },
          lualine_c = { diagnostics, diff },
          lualine_x = {
            lsp_info,
            spaces,
            "encoding",
            require("lazyvim.util").lualine.cmp_source("codeium"),
            fileType,
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
  -- 配置Noice通知消息
  {
    "folke/noice.nvim",
    opts = function(_, opts)
      table.insert(opts.routes, {
        filter = {
          event = "notify",
          find = "No information available",
        },
        opts = {
          skip = true,
        },
      })
      table.insert(opts.routes, {
        filter = {
          event = "lsp",
          find = "Linting...",
        },
        opts = {
          skip = true,
        },
      })
      table.insert(opts.presets, {
        lsp_doc_border = true,
        inc_rename = true,
      })
    end,
  },
  {
    "rcarriga/nvim-notify",
    opts = {
      background_colour = "#000000",
    },
  },
  -- 配置 IncLine
  {
    "b0o/incline.nvim",
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

          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          if filename == "" then
            filename = "[No Name]"
          end
          local ft_icon, ft_color = devicons.get_icon_color(filename)
          local modified = vim.bo[props.buf].modified

          local function get_git_diff()
            local icons = { removed = "", changed = "", added = "" }
            local signs = vim.b[props.buf].gitsigns_status_dict
            local labels = {}
            if signs == nil then
              return labels
            end
            for name, icon in pairs(icons) do
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
            local icons = { error = "", warn = "", info = "", hint = "" }
            local label = {}

            for severity, icon in pairs(icons) do
              local n = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity[string.upper(severity)] })
              if n > 0 then
                table.insert(label, { " " .. icon .. " " .. n .. " ", group = "DiagnosticSign" .. severity })
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
            ft_icon and { " ", ft_icon, " ", guibg = ft_color, guifg = helpers.contrast_color(ft_color) } or "",
            " ",
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
}
