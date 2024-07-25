return {
  "williamboman/mason-lspconfig.nvim",
  dependencies = {
    "williamboman/mason.nvim"
  },
  opts = {
    ensure_installed = { "tsserver", "rust_analyzer", "clangd", "lua_ls" },
    handlers = {
      function(server_name)
        require("lspconfig")[server_name].setup({})
      end
    }
  }
}
