vim.o.background = "dark"

local colors = {
  vscDarkBlue = "#223E55",
  vscLightGreen = "#B5CEA8"
}

vim.o.background = "dark"

--- @type LazyPluginSpec
return {
  "Mofiqul/vscode.nvim",
  priority = 1000,

  config = function()
    local vscode = require("vscode")

    vscode.load()

    vscode.setup({
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
    })

  end,
}
