return {
  -- 时长统计工具
  { "wakatime/vim-wakatime", lazy = false },
  -- 翻译插件
  {
    "JuanZoran/Trans.nvim",
    event = "BufWinEnter",
    keys = {
      -- 可以换成其他你想映射的键
      -- { "<leader>t", mode = { "n", "x" }, icon = "󰊿 ", desc = "󰊿 Translate" },
      { "<leader>tt", mode = { "n", "x" }, "<Cmd>Translate<CR>", desc = "󰊿 Translate" },
      { "<leader>tp", mode = { "n", "x" }, "<Cmd>TransPlay<CR>", desc = " Auto Play" },
      -- 目前这个功能的视窗还没有做好，可以在配置里将view.i改成hover
      { "<leader>ti", "<Cmd>TranslateInput<CR>", desc = "󰊿 Translate From Input" },
    },
    dependencies = { "kkharji/sqlite.lua" },
    opts = {
      theme = "tokyonight",
    },
  },
  -- 多光标
  {
    "mg979/vim-visual-multi",
    event = "BufWinEnter",
  },
  -- 内部终端
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      size = 20,
      open_mapping = [[<C-t>]],
      hide_numbers = true,
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      persist_size = true,
      direction = "float",
      close_on_exit = true,
      shell = vim.o.shell,
      float_opts = {
        border = "curved",
        winblend = 0,
        highlights = {
          border = "Normal",
          background = "Normal",
        },
      },
    },
  },
}
