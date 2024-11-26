require("canedca1.remap")
require("canedca1.set")

if not vim.g.vscode then
  require("canedca1.lazy_init")
end

-- disable fastbrowse to close netrw on navigation to a file
vim.g.netrw_fastbrowse = 0

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

autocmd("FileType", {
    callback = function()
        local bufnr = vim.fn.bufnr('%')
        vim.keymap.set("n", "<Enter>", function()
            vim.api.nvim_command([[execute "normal! \<cr>"]])
            vim.api.nvim_command(bufnr .. 'bd')
        end, { buffer = bufnr })
    end,
    pattern = "qf",
})

for _, method in ipairs({ 'textDocument/diagnostic', 'workspace/diagnostic' }) do
    local default_diagnostic_handler = vim.lsp.handlers[method]
    vim.lsp.handlers[method] = function(err, result, context, config)
        if err ~= nil and err.code < 0 then
            return
        end
        return default_diagnostic_handler(err, result, context, config)
    end
end
