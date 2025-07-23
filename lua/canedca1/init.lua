require("canedca1.remap")
require("canedca1.set")

if not vim.g.vscode then
  require("canedca1.lazy_init")
end

-- disable fastbrowse to close netrw on navigation to a file
vim.g.netrw_fastbrowse = 0

if jit.os:find("Windows") ~= nil then
  vim.keymap.set("n", "K", "")
end

if vim.g.neovide then
  vim.g.neovide_position_animation_length = 0.05
  vim.g.neovide_cursor_animation_length = 0.05
  vim.g.neovide_cursor_trail_size = 0.1
  vim.g.neovide_cursor_animate_in_insert_mode = true
  vim.g.neovide_cursor_animate_command_line = true
  vim.g.neovide_scroll_animation_far_lines = 0
  vim.g.neovide_scroll_animation_length = 0.05

  local remap = vim.keymap.set
  remap({ "i", "c" }, "<C-BS>", "<C-w>", { noremap = true })
end

vim.opt.list = true
vim.opt.listchars = { tab = "▸▸", trail = "·" }

vim.opt.relativenumber = true

vim.opt.number = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.wrap = false
vim.opt.smartindent = true

vim.diagnostic.config({
  virtual_text = false,
})

local autocmd = vim.api.nvim_create_autocmd

autocmd("CmdlineEnter", {
  pattern = "/,\\?",
  callback = function() vim.opt.hlsearch = true end
})

autocmd("CmdlineLeave", {
  pattern = "/,\\?",
  callback = function() vim.opt.hlsearch = false end
})

for _, method in ipairs({ 'textDocument/diagnostic', 'workspace/diagnostic' }) do
    local default_diagnostic_handler = vim.lsp.handlers[method]
    vim.lsp.handlers[method] = function(err, result, context)
        if err ~= nil and err.code < 0 then
            return
        end
        return default_diagnostic_handler(err, result, context)
    end
end

-- vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#ffffff", bg = "#ffffff" })
