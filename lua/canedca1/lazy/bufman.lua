local opts = {
  noremap = true,
  silent = true
}

return {
  "j-morano/buffer_manager.nvim",
  dependencies = {
    {
      "nvim-lua/plenary.nvim",
      tag = "v0.1.4"
    }
  },

  config = function()
    require("buffer_manager").setup({
      width = 0.5,
      height = 0.375
    })

    local setkeys = vim.keymap.set
    setkeys(
      "n",
      "<leader>bv",
      function() require("buffer_manager.ui").toggle_quick_menu() end,
      opts
    )
  end
}
