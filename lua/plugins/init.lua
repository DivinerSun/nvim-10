vim.pack.add({
  -- common dependencies
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/MunifTanjim/nui.nvim",
  "https://github.com/nvim-tree/nvim-web-devicons",

  {
    src = 'https://github.com/nvim-neo-tree/neo-tree.nvim',
    version = vim.version.range('3')
  },
  -- neo-tree dep
  "https://github.com/saifulapm/neotree-file-nesting-config",

  { src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
})




-- Import Plugins Config
require("plugins/theme")
require("plugins/neo-tree")
