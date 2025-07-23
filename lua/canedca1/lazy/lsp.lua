--- @type LazyPluginBase
--- @diagnostic disable-next-line: missing-fields
return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "onsails/lspkind.nvim",
  },

  priority = 1000,

  config = function()
    local cmp = require("cmp")
    local cmp_types = require("cmp.types")
    local lspkind = require("lspkind")

    --- @type cmp.SelectOption
    local cmp_select = {
      behavior = "select"
    }

    cmp.setup{
      completion = {
        completopt = "menu,menuone,noselect"
      },

      formatting = {
        expandable_indicator = true,
        fields = { "kind", "abbr", "menu" },
        format = lspkind.cmp_format{
          mode = 'symbol',
          maxwidth = {
            menu = 25,
            abbr = 25,
          },

          ellipsis_char = '...',
        },
      },

      sources = {
        { name = "nvim_lsp" },
        { name = "nvim_lsp_signature_help", max_item_count = 1 },
        -- { name = "nvim_lua", max_item_count = 5 },
        -- { name = "buffer", max_item_count = 5 }
      },

      mapping = cmp.mapping.preset.insert{
        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4)),
        ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4)),
        ['<C-g>'] = cmp.mapping(
          function()
            if cmp.visible_docs() then
              cmp.close_docs()
            else
              cmp.open_docs()
            end
          end
        ),

        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-y>'] = cmp.mapping(
          function(_)
            cmp.confirm({
              select = false,
              behavior = cmp_types.cmp.ConfirmBehavior.Replace
            })
            vim.api.nvim_set_hl(0, "SnippetTabstop", {})
          end,
          { "i", "s" }
        ),

        ["<C-space>"] = cmp.mapping(function() cmp.complete() end, { "i", "s" })
      },

      window = {
        completion = cmp.config.window.bordered({ border = "single" }),
        documentation = cmp.config.window.bordered({ border = "single" })
      },
    }

    vim.api.nvim_create_autocmd("LspAttach", {
      desc = "LSP Keybinds",
      callback = function(event)
        local opts = { buffer = event.buf, remap = false }

        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover({ border = "single" }) end, opts)
        vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
        vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
        vim.keymap.set({ "i", "n" }, "<A-.>", function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
        vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set({"i", "n"}, "<C-g>", function() vim.lsp.buf.signature_help() end, opts)

        vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ float = true, count = -1 }) end, opts)
        vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ float = true, count = 1 }) end, opts)

        vim.keymap.set("i", "<C-n>", function()
          if not cmp.visible() then cmp.complete() end
        end)

        vim.keymap.set("i", "<C-p>", function()
          if not cmp.visible() then cmp.complete() end
        end)
      end
    })

    vim.diagnostic.config({
      float = {
        focusable = true,
        style = true,
        border = "single",
        source = "if_many",
        header = "",
        prefix = "",
      }
    })

    --   -- Customization for Pmenu
    vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#414550", fg = "NONE" })
    vim.api.nvim_set_hl(0, "Pmenu", { fg = "#E5E5E5", bg = "#222222" })
  end
}
