local opts = {
  noremap = true,
  silent = true
}
return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.5",
  dependencies = {
    {
      "nvim-lua/plenary.nvim",
      tag = "v0.1.4"
    }
  },

  opts = {},
  init = function()
    local telescope = require("telescope.builtin")
    vim.keymap.set('n', '<leader>pf', telescope.find_files, opts)
    vim.keymap.set('n', '<C-p>', telescope.git_files, opts)
    vim.keymap.set('n', '<leader>ps', telescope.live_grep, opts)
    vim.keymap.set('n', '<leader>vh', telescope.help_tags, opts)
    vim.keymap.set( "n", "<leader>bv", telescope.buffers, opts)
  end
}
