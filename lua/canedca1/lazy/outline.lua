return {
  "hedyhli/outline.nvim",
  lazy = true,
  cmd = { "Outline", "OutlineOpen" },
  config = function()
    vim.keymap.set(
      "n",
      "<leader>o",
      "<cmd>Outline<CR>",
      { noremap = true, silent = true }
    )

    require("outline").setup{}
  end
}
