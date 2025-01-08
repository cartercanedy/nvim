vim.o.autoread = true
vim.o.signcolumn = "yes:1"

vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
  command = "if mode() != 'c' | checktime | endif",
  pattern = { "*" },
})

vim.o.scrolloff = 8
vim.o.swapfile = false
vim.o.backup = false

vim.o.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.o.undofile = true

vim.o.termguicolors = true

vim.o.updatetime = 50
