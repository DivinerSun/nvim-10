return {
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
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
          registries = {
            "github:mason-org/mason-registry",
          },
          providers = {
            "mason.providers.registry-api",
            "mason.providers.client",
          },
          github = {
            download_url_template = "https://github.com/%s/releases/download/%s/%s",
          },
        },
      },
      {
        "neovim/nvim-lspconfig",
        dependencies = { "saghen/blink.cmp" },
        opts = {
          servers = {
            lua_ls = {},
          },
        },
        config = function()
          local blink_capabilities = require("blink.cmp").get_lsp_capabilities({}, false)
          local capabilities = vim.lsp.protocol.make_client_capabilities()
          capabilities = vim.tbl_deep_extend("force", capabilities, blink_capabilities)

          capabilities = vim.tbl_deep_extend("force", capabilities, {
            textDocument = {
              foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true,
              },
            },
          })
          vim.lsp.config("*", { capabilities = capabilities })
        end,
      },
    },
    opts = {
      automatic_enable = true,
      ensure_installed = { "lua_ls", "rust_analyzer" },
    },
  },
}
