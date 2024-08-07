return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.install").compilers = { "zig" }

    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "vimdoc",
        "javascript",
        "typescript",
        "c",
        "lua",
        "rust",
        "jsdoc",
        "bash",
        "make",
        "cmake",
        "cpp"
      },

      sync_install = false,
      auto_install = true,
      indent = {
        enable = true
      },

      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { "markdown" }
      }
    })
  end,
}
