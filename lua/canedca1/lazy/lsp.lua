return {
  "VonHeikemen/lsp-zero.nvim",
  dependencies = {
    "rafamadriz/friendly-snippets",
    "neovim/nvim-lspconfig",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/nvim-cmp",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
  },
  branch = "v3.x",
  priority = 500,
  config = function()
    local cmp = require("cmp")
    local lsp = require("lsp-zero")
    local luasnip = require("luasnip")

    lsp.preset("recommended")

    local feedkeys = vim.api.nvim_feedkeys
    local get_termcodes = vim.api.nvim_replace_termcodes

    local cmp_select = { behavior = cmp.SelectBehavior.Replace }
    local cmp_mappings = lsp.defaults.cmp_mappings({
      ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
      ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
      ['<C-y>'] = cmp.mapping.confirm({ select = true }),
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
        elseif luasnip.locally_jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
    })

    lsp.setup({
      mapping = cmp_mappings,
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" }
      }, {
        { name = "buffer" }
      })
    })

    lsp.setup_servers({ "ts_ls", "rust_analyzer", "clangd", "lua_ls", "csharp_ls" })

    lsp.set_preferences({
        suggest_lsp_servers = true,
        sign_icons = {
            error = "e",
            warn = "w",
            hint = "h",
            info = "i"
        }
    })

    lsp.on_attach(function(_, bufnr)
      local opts = { buffer = bufnr, remap = false }

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
    end)

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
