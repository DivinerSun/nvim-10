return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },
  -- 自定义 Which-Key 布局格式
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts_extend = { "spec" },
    opts = {
      preset = "modern",
      spec = {
        {
          mode = { "n", "v" },
          { "<leader>t", group = "Translate", icon = { icon = "󰊿", color = "cyan" } },
        },
      },
    },
  },
  -- 自定义Tokyonight主题配置
  {
    "folke/tokyonight.nvim",
    opts = {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
        comments = { italic = true },
        keywords = { italic = true },
        functions = { italic = true },
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
  -- 自定义 Dashboard 信息
  {
    "snacks.nvim",
    opts = {
      indent = { enabled = true },
      input = { enabled = true },
      notifier = { enabled = true },
      scope = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = false }, -- we set this in options.lua
      toggle = { map = LazyVim.safe_keymap_set },
      words = { enabled = true },
      dashboard = {
        preset = {
          header = [[
            $$$$$$$\  $$\            $$\                             $$\ $$\    $$\ $$\               
            $$  __$$\ \__|           \__|                            $  |$$ |   $$ |\__|              
            $$ |  $$ |$$\ $$\    $$\ $$\ $$$$$$$\   $$$$$$\   $$$$$$\\_/ $$ |   $$ |$$\ $$$$$$\$$$$\  
            $$ |  $$ |$$ |\$$\  $$  |$$ |$$  __$$\ $$  __$$\ $$  __$$\   \$$\  $$  |$$ |$$  _$$  _$$\ 
            $$ |  $$ |$$ | \$$\$$  / $$ |$$ |  $$ |$$$$$$$$ |$$ |  \__|   \$$\$$  / $$ |$$ / $$ / $$ |
            $$ |  $$ |$$ |  \$$$  /  $$ |$$ |  $$ |$$   ____|$$ |          \$$$  /  $$ |$$ | $$ | $$ |
            $$$$$$$  |$$ |   \$  /   $$ |$$ |  $$ |\$$$$$$$\ $$ |           \$  /   $$ |$$ | $$ | $$ |
            \_______/ \__|    \_/    \__|\__|  \__| \_______|\__|            \_/    \__|\__| \__| \__|
          ]],
          -- stylua: ignore
          ---@type snacks.dashboard.Item[]
          keys = {
            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
            { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
      },
    },
    keys = {
      {
        "<leader>n",
        function()
          Snacks.notifier.show_history()
        end,
        desc = "Notification History",
      },
      {
        "<leader>un",
        function()
          Snacks.notifier.hide()
        end,
        desc = "Dismiss All Notifications",
      },
    },
  },
  -- 自定义顶部buffer状态栏
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
      { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
      { "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete Buffers to the Right" },
      { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete Buffers to the Left" },
      { "<A-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
      { "<A-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
      { "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
      { "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
      { "[B", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer prev" },
      { "]B", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer next" },
    },
    opts = {
      options = {
      -- stylua: ignore
      close_command = function(n) Snacks.bufdelete(n) end,
      -- stylua: ignore
      right_mouse_command = function(n) Snacks.bufdelete(n) end,
        diagnostics = "nvim_lsp",
        always_show_bufferline = true,
        diagnostics_indicator = function(_, _, diag)
          local icons = LazyVim.config.icons.diagnostics
          local ret = (diag.error and icons.Error .. diag.error .. " " or "")
            .. (diag.warning and icons.Warn .. diag.warning or "")
          return vim.trim(ret)
        end,
        offsets = {
          {
            filetype = "neo-tree",
            text = "Neo-tree",
            highlight = "Directory",
            text_align = "left",
          },
        },
        ---@param opts bufferline.IconFetcherOpts
        get_element_icon = function(opts)
          return LazyVim.config.icons.ft[opts.filetype]
        end,
      },
    },
    config = function(_, opts)
      require("bufferline").setup(opts)
      -- Fix bufferline when restoring a session
      vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
        callback = function()
          vim.schedule(function()
            pcall(nvim_bufferline)
          end)
        end,
      })
    end,
  },
  -- 自定义底部状态栏
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      vim.o.laststatus = vim.g.lualine_laststatus

      local icons = LazyVim.config.icons
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
        symbols = {
          error = icons.diagnostics.Error,
          warn = icons.diagnostics.Warn,
          info = icons.diagnostics.Info,
          hint = icons.diagnostics.Hint,
        },
        colored = true,
        update_in_insert = false,
        always_visible = false,
      }

      local diff = {
        "diff",
        colored = true,
        symbols = {
          added = icons.git.added .. " ",
          modified = icons.git.modified .. " ",
          removed = icons.git.removed .. " ",
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
      local lsp_info = {
        function()
          local conform = require("conform")
          local lint = require("lint")

          local msg = "[ LS Inactive ]"
          local buf_clients = vim.lsp.get_clients({ bufnr = 0 })
          local buf_client_names = {}
          if next(buf_clients) == nil then
            if type(msg) == "boolean" or #msg == 0 then
              return "[ LS Inactive ]"
            end
            return msg
          end
          for _, client in pairs(buf_clients) do
            if client.name ~= "conform" and client.name ~= "copilot" then
              table.insert(buf_client_names, client.name)
            end
          end
          local supported_formatters = conform.list_formatters_for_buffer(0)
          vim.list_extend(buf_client_names, supported_formatters)
          local supported_linters = lint.get_running(0)
          vim.list_extend(buf_client_names, supported_linters)
          -- local unique_client_names = vim.fn.uniq(buf_client_names)
          msg = table.concat(buf_client_names, ", ")
          return "[" .. msg .. "]"
        end,
        icon = icons.kinds.Constructor .. "",
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
          },
          lualine_b = { mode, branch },
          lualine_c = { LazyVim.lualine.root_dir(), diagnostics, diff },
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
  -- 配置 IncLine 导航
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
  -- 代码块顶部固定
  {
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
      require("treesitter-context").setup({
        enable = true,
        max_lines = 0,
        min_window_height = 0,
        line_numbers = true,
        multiline_threshold = 20,
        trim_scope = "outer",
        mode = "cursor",
        separator = nil,
        zindex = 20,
        on_attach = nil,
      })
    end,
  },
}
