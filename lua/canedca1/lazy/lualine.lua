return {
  "cartercanedy/lualine.nvim",

  opts = {
    options = {
      component_separators = {
        left = '',
        right = ''
      },

      section_separators = {
        left = '',
        right = ''
      },

      disabled_filetypes = {
        statusline = {},
        winbar = {},
      },

      refresh = {
        statusline = 1000,
        tabline = 1000,
        winbar = 1000,
      },

      icons_enabled = true,
      theme = "tomorrow_night",
      ignore_focus = {},
      always_divide_middle = true,
      globalstatus = true
    },

    sections = {
      lualine_a = {
        'mode'
      },

      lualine_b = {
        'branch',
        'diff',
        'diagnostics',
      },

      lualine_c = {
        'filename',
        {
          timer = {
            progress_enddelay = 500,
            spinner = 250,
            lsp_client_name_enddelay = 500
          },
        },
      },

      lualine_x = {
        'encoding',
        'fileformat',
        'filetype'
      },

      lualine_y = {
        'progress'
      },

      lualine_z = {
        'location'
      },
    },

    inactive_sections = {
      lualine_a = {},
      lualine_b = {},

      lualine_c = {
        'filename'
      },

      lualine_x = {
        'location'
      },

      lualine_y = {},
      lualine_z = {}
    },

    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {}
  }
}

