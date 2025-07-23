---@type LazyPluginSpec
return {
  "j-hui/fidget.nvim",
  config = function()
    require("fidget").setup{
      progress = {
        display = {
          done_icon = "✔  ",
          render_limit = 16,          -- How many LSP messages to show at once
          done_ttl = 3,               -- How long a message should persist after completion
          done_style = "Constant",    -- Highlight group for completed LSP tasks
          progress_ttl = math.huge,   -- How long a message should persist when in progress
          progress_icon =             -- Icon shown when LSP progress tasks are in progress
            { "dots" },
          progress_style =            -- Highlight group for in-progress LSP tasks
            "WarningMsg",
          group_style = "Title",      -- Highlight group for group name (LSP server name)
          icon_style = "Question",    -- Highlight group for group icons
          priority = 30,              -- Ordering priority for LSP notification group
          skip_history = true,        -- Whether progress notifications should be omitted from history
          format_message =            -- How to format a progress message
            require("fidget.progress.display").default_format_message,
          format_annote =             -- How to format a progress annotation
            function(msg) return msg.title end,
          format_group_name =         -- How to format a progress notification group's name
            function(group) return tostring(group) end,
          overrides = {               -- Override options from the default notification config
            rust_analyzer = { name = "rust-analyzer" },
          },
        }
      },

      notification = {
        window = {
          winblend = 75,
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
