return {
  {
    "saghen/blink.cmp",
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
        },
      }
      opts.sources = {
        compat = { "calc", "emoji", "tailwind", "tailwindcss" },
        default = { "lazydev", "lsp", "path", "snippets", "buffer" },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 100,
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
