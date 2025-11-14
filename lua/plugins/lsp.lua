return {
  -- 在Lazy.nvim配置中指定版本
  {
    "mason-org/mason.nvim",
    opts = {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {},
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
  },
  -- LSP 信息多行显示
  {
    -- "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    "DivinerSun/lsp_lines.nvim",
    config = function()
      vim.diagnostic.config({
        virtual_text = false,
        virtual_lines = false,
      })
      require("lsp_lines").setup()
    end,
  },
}
