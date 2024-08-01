require("canedca1.remap")
require("canedca1.set")
require("canedca1.lazy_init")

vim.g.rust_recommended_style = 0

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

