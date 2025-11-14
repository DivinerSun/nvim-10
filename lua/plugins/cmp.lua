return {
  {
    "Exafunction/windsurf.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    config = function()
      require("codeium").setup({
        -- Optionally disable cmp source if using virtual text only
        enable_cmp_source = false,
        virtual_text = {
          enabled = true,
          -- These are the defaults
          -- Set to true if you never want completions to be shown automatically.
          manual = false,
          -- A mapping of filetype to true or false, to enable virtual text.
          filetypes = {},
          -- Whether to enable virtual text of not for filetypes not specifically listed above.
          default_filetype_enabled = true,
          -- How long to wait (in ms) before requesting completions after typing stops.
          idle_delay = 75,
          -- Priority of the virtual text. This usually ensures that the completions appear on top of
          -- other plugins that also add virtual text, such as LSP inlay hints, but can be modified if
          -- desired.
          virtual_text_priority = 65535,
          -- Set to false to disable all key bindings for managing completions.
          map_keys = true,
          -- The key to press when hitting the accept keybinding but no completion is showing.
          -- Defaults to \t normally or <c-n> when a popup is showing.
          accept_fallback = nil,
          -- Key bindings for managing completions in virtual text mode.
          key_bindings = {
            -- Accept the current completion.
            accept = "<C-Enter>",
            -- Accept the next word.
            accept_word = false,
            -- Accept the next line.
            accept_line = false,
            -- Clear the virtual text.
            clear = false,
            -- Cycle to the next completion.
            next = "<C-j>",
            -- Cycle to the previous completion.
            prev = "<C-k>",
          },
        },
      })
    end,
  },
  {
    "saghen/blink.cmp",
    dependencies = {
      -- add source
      "codeium.nvim",
      {
        "Exafunction/codeium.nvim",
      },
      "saghen/blink.compat",
      { "hrsh7th/cmp-calc" },
      { "hrsh7th/cmp-emoji" },
      {
        "roobert/tailwindcss-colorizer-cmp.nvim",
        config = function()
          require("tailwindcss-colorizer-cmp").setup({
            color_square_width = 2,
          })
        end,
      },
      "Kaiser-Yang/blink-cmp-avante",
    },
    opts = function(_, opts)
      local icons = LazyVim.config.icons
      opts.appearance = {
        use_nvim_cmp_as_default = false,
        nerd_font_variant = "mono",
        kind_icons = {
          Text = icons.kinds.Text,
          Method = icons.kinds.Method,
          Function = icons.kinds.Function,
          Constructor = icons.kinds.Constructor,

          Field = icons.kinds.Field,
          Variable = icons.kinds.Variable,
          Property = icons.kinds.Property,

          Class = icons.kinds.Class,
          Interface = icons.kinds.Interface,
          Struct = icons.kinds.Struct,
          Module = icons.kinds.Module,

          Unit = icons.kinds.Unit,
          Value = icons.kinds.Value,
          Enum = icons.kinds.Enum,
          EnumMember = icons.kinds.EnumMember,

          Keyword = icons.kinds.Keyword,
          Constant = icons.kinds.Constant,

          Snippet = icons.kinds.Snippet,
          Color = icons.kinds.Color,
          File = icons.kinds.File,
          Reference = icons.kinds.Reference,
          Folder = icons.kinds.Folder,
          Event = icons.kinds.Event,
          Operator = icons.kinds.Operator,
          TypeParameter = icons.kinds.TypeParameter,

          Codeium = icons.kinds.Copilot,
        },
      }
      opts.sources = {
        compat = {
          "calc",
          "emoji",
          "tailwind",
          "tailwindcss",
          "tailwindcss-colorizer",
          "codeium",
          "avante_commands",
          "avante_mentions",
          "avante_files",
          "avante",
          "crates",
        },
        default = { "lazydev", "lsp", "path", "snippets", "buffer", "codeium", "avante", "crates" },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 100,
          },
          codeium = { name = "Codeium", module = "codeium.blink", async = true },
          avante = {
            module = "blink-cmp-avante",
            name = "Avante",
            opts = {
              -- options for blink-cmp-avante
            },
          },
          avante_commands = {
            name = "avante_commands",
            module = "blink.compat.source",
            score_offset = 90, -- show at a higher priority than lsp
            opts = {},
          },
          avante_files = {
            name = "avante_files",
            module = "blink.compat.source",
            score_offset = 100, -- show at a higher priority than lsp
            opts = {},
          },
          avante_mentions = {
            name = "avante_mentions",
            module = "blink.compat.source",
            score_offset = 1000, -- show at a higher priority than lsp
            opts = {},
          },
        },
      }
      opts.keymap = {
        preset = "enter",
        ["<C-y>"] = { "select_and_accept" },
        ["<Tab>"] = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
      }
      return opts
    end,
  },
}
