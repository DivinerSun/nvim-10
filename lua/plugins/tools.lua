return {
  {
    "JuanZoran/Trans.nvim",
    event = "BufWinEnter",
    keys = {
      -- 可以换成其他你想映射的键
      { "<leader>t", mode = { "n", "x" }, "", desc = "󰊿 Translate" },
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
}
