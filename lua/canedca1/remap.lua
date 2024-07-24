local opts = {
  noremap = true,
  silent = true
}

local keymap_set = vim.keymap.set

keymap_set("n", "<Space>fn", ":bnext<Enter>", opts)
keymap_set("n", "<Space>fp", ":bprev<Enter>", opts)
keymap_set("n", "<Space>fd", ":bdelete<Enter>", opts)
keymap_set("n", "<Space>pv", vim.cmd.Ex, opts)
keymap_set({ "n", "v" }, "<Space>y", [["+y]], opts)
keymap_set({ "n", "v" }, "<Space>Y", [["+Y]], opts)
keymap_set("n", "<C-k>", ":cnext<Enter>zz", opts)
keymap_set("n", "<C-j>", ":cprev<Enter>zz", opts)
keymap_set("n", "<Space>k", ":lnext<Enter>zz", opts)
keymap_set("n", "<Space>j", ":lprev<Enter>zz", opts)
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<space>p", [["_dP]])

vim.keymap.set({ "n", "v" }, "<space>y", [["+y]])
vim.keymap.set("n", "<space>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<space>d", [["_d]])

vim.keymap.set("n", "Q", "<C-q>")
vim.keymap.set("n", "<space>f", vim.lsp.buf.format)

vim.keymap.set("n", "<space>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<space>x", "<cmd>!chmod +x %<CR>", { silent = true })
