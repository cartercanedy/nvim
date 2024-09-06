return {
  "williamboman/mason-lspconfig.nvim",
  dependencies = {
    "williamboman/mason.nvim",
    "hrsh7th/cmp-nvim-lsp"
  },
  opts = {
    ensure_installed = { "tsserver", "rust_analyzer", "clangd", "lua_ls", "csharp_ls" },
    handlers = {
      --- default lsp setup handler
      --- @param server_name string
      function(server_name)
        if server_name == "tsserver" then
          server_name = "ts_ls"
        end

        require("lspconfig")[server_name].setup({})
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
