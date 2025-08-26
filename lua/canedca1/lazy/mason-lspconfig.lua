return {
  "williamboman/mason-lspconfig.nvim",
  dependencies = {
    "williamboman/mason.nvim",
    "hrsh7th/cmp-nvim-lsp"
  },

  opts = {
    ensure_installed = { "ts_ls", "rust_analyzer", "clangd", "lua_ls", "omnisharp" },
    handlers = {
      --- default lsp setup handler
      --- @param server_name string
      function(server_name)
        local capabilities = vim.tbl_deep_extend(
          "force",
          {},
          vim.lsp.protocol.make_client_capabilities(),
          require("cmp_nvim_lsp").default_capabilities()
        )

        require("lspconfig")[server_name].setup({
          capabilities = capabilities
        })
      end,

      ["rust_analyzer"] = function()
        local capabilities = vim.tbl_deep_extend(
          "force",
          {},
          vim.lsp.protocol.make_client_capabilities(),
          require("cmp_nvim_lsp").default_capabilities()
        )

        require("lspconfig").rust_analyzer.setup({
          capabilities = capabilities,
          settings = { ["rust-analyzer"] = { } }
        })
      end,

      --- Lua-language-server attach handler
      ["lua_ls"] = function()
        local capabilities = vim.tbl_deep_extend(
          "force",
          {},
          vim.lsp.protocol.make_client_capabilities(),
          require("cmp_nvim_lsp").default_capabilities()
        )

        require("lspconfig").lua_ls.setup {
          capabilities = capabilities,
          settings = {
            Lua = {
              runtime = { version = "Lua 5.1" },
              diagnostics = {
                globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
              }
            }
          }
        }
      end,
    }
  }
}
