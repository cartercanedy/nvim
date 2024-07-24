require("canedca1.remap")
require("canedca1.set")
require("canedca1.lazy_init")

vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2

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

