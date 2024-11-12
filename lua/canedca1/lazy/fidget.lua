return {
  "j-hui/fidget.nvim",
  config = function()
    require("fidget").setup{
      progress = {
        display = {
          done_icon = "✔  "
        }
      },

      notification = {
        window = {
          winblend = 25,
          max_width = 40,
          normal_hl = "Operator",
          border = "rounded",
          x_padding = 1,
          y_padding = 1,
        },

        view = {
          stack_upwards = true,
          icon_separator = " ",
          group_separator = "---",
          group_separator_hl = "Comment",
        },

        configs = { default = require("fidget.notification").default_config }
      },
    }
  end
}
