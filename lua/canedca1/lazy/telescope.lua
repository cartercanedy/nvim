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
    vim.keymap.set('n', '<space>pf', telescope.find_files, {})
    vim.keymap.set('n', '<C-p>', telescope.git_files, {})
    vim.keymap.set('n', '<space>ps', function() telescope.live_grep() end)
    vim.keymap.set('n', '<space>vh', telescope.help_tags, {})
  end
}
