return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/nvim-cmp",
  },

  priority = 500,

  config = function()
    local feedkeys = vim.api.nvim_feedkeys
    local get_termcodes = vim.api.nvim_replace_termcodes

    local cmp = require("cmp")
    local lspconfig = require("lspconfig")

    local defaults = lspconfig.util.default_config
    local cmp_select = { behavior = cmp.SelectBehavior.Replace }

    defaults.capabilities = vim.tbl_deep_extend(
      "force",
      defaults.capabilities,
      require("cmp_nvim_lsp").default_capabilities()
    )

    cmp.setup{
      sources = {
        { name = "nvim_lsp" },
        { name = "buffer" }
      },
      snippet = {
        expand = function(args)
          vim.snippet.expand(args.body)
        end
      },
      mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-y>'] = cmp.mapping(
          function(_)
            print("here")
            cmp.confirm({ select = false, behavior = cmp.ConfirmBehavior.Replace })
            vim.api.nvim_set_hl(0, "SnippetTabstop", {})
          end,
          { "i", "s" }
        ),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<Enter>"] = cmp.mapping(
          function(_)
            cmp.mapping.abort()
            local codes = get_termcodes("<CR>", true, true, true)
            feedkeys(codes, "n", true)
          end
        ),

        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end, { "i", "s" }),
      }
    }

    vim.api.nvim_create_autocmd("LspAttach", {
      desc = "LSP Keybinds",
      callback = function(event)
        local opts = { buffer = event.buf, remap = false }

        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set("n", "<Space>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
        vim.keymap.set("n", "<Space>vd", function() vim.diagnostic.open_float() end, opts)
        vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
        vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
        vim.keymap.set("n", "<C-a>", function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set("n", "<Space>vrr", function() vim.lsp.buf.references() end, opts)
        vim.keymap.set("n", "<Space>vrn", function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set({"i", "n"}, "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
      end
    })


    vim.diagnostic.config({
      float = {
        focusable = true,
        style = true,
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      }
    })
  end
}
