local compiler_toolchain

if jit.os == "Windows" then
  compiler_toolchain = { "zig" }
else
  compiler_toolchain = { "gcc" }
end

return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.install").compilers = compiler_toolchain

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
