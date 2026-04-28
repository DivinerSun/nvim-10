return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = { enabled = true },
    dashboard = {
      enabled = true,
      preset = {
        header = [[
          ==================================================================================================
          ||   /$$$$$$$  /$$            /$$                              /$$ /$$    /$$ /$$               ||
          ||  | $$__  $$|__/           |__/                             | $/| $$   | $$|__/               ||
          ||  | $$  \ $$ /$$ /$$    /$$ /$$ /$$$$$$$   /$$$$$$   /$$$$$$|_/ | $$   | $$ /$$ /$$$$$$/$$$$  ||
          ||  | $$  | $$| $$|  $$  /$$/| $$| $$__  $$ /$$__  $$ /$$__  $$   |  $$ / $$/| $$| $$_  $$_  $$ ||
          ||  | $$  | $$| $$ \  $$/$$/ | $$| $$  \ $$| $$$$$$$$| $$  \__/    \  $$ $$/ | $$| $$ \ $$ \ $$ ||
          ||  | $$  | $$| $$  \  $$$/  | $$| $$  | $$| $$_____/| $$           \  $$$/  | $$| $$ | $$ | $$ ||
          ||  | $$$$$$$/| $$   \  $/   | $$| $$  | $$|  $$$$$$$| $$            \  $/   | $$| $$ | $$ | $$ ||
          ||  |_______/ |__/    \_/    |__/|__/  |__/ \_______/|__/             \_/    |__/|__/ |__/ |__/ ||
          ==================================================================================================
        ]],
      },
    },
    explorer = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    notifier = {
      enabled = true,
      timeout = 3000,
    },
    picker = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    styles = {
      notification = {
        wo = { wrap = true } -- Wrap notifications
      }
    }
  },
}
