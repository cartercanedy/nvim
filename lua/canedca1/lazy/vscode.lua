vim.o.background = "dark"

local colors = {
  vscDarkBlue = "#223E55",
  vscLightGreen = "#B5CEA8"
}

return {
  "Mofiqul/vscode.nvim",
  commit = "18097b7",
  priority = 1000,

  init = function()
    vim.o.background = 'dark'
  end,

  opts = {
    -- Alternatively set style in setup
    -- style = 'light'

    -- Enable transparent background
    transparent = true,

    -- Enable italic comment
    italic_comments = false,

    -- Disable nvim-tree background color
    disable_nvimtree_bg = true,

    -- Override colors (see ./lua/vscode/colors.lua)
    color_overrides = {
      vscLineNumber = '#FFFFFF',
    },

    -- Override highlight groups (see ./lua/vscode/theme.lua)
    group_overrides = {
      -- this supports the same val table as vim.api.nvim_set_hl
      -- use colors from this colorscheme by requiring vscode.colors!
      Cursor = {
        fg = colors.vscDarkBlue,
        bg = colors.vscLightGreen,
        bold = true
      },
    }
  },
  config = function() require("vscode").load() end
}
