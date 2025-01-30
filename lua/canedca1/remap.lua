local opts = {
  noremap = true,
  silent = true
}

vim.g.mapleader = " "

local remap = vim.keymap.set

remap("n", "<leader>fn", ":bnext<Enter>", opts)
remap("n", "<leader>fp", ":bprev<Enter>", opts)
remap("n", "<leader>fd", ":bdelete<Enter>", opts)
remap("n", "<leader>pv", vim.cmd.Ex, opts)
remap({ "n", "v" }, "<leader>y", [["+y]], opts)
remap({ "n", "v" }, "<leader>Y", [["+Y]], opts)
remap("n", "<C-k>", ":cnext<Enter>zz", opts)
remap("n", "<C-j>", ":cprev<Enter>zz", opts)
remap("n", "<leader>k", ":lnext<Enter>zz", opts)
remap("n", "<leader>j", ":lprev<Enter>zz", opts)

remap("v", "J", ":m '>+1<CR>gv=gv", opts)
remap("v", "K", ":m '<-2<CR>gv=gv", opts)

remap("n", "J", "mzJ`z", opts)
remap("n", "<C-d>", "<C-d>zz", opts)
remap("n", "<C-u>", "<C-u>zz", opts)
remap("n", "n", "nzzzv", opts)
remap("n", "N", "Nzzzv", opts)

remap("x", "<leader>p", [["_dP]], opts)

remap({ "n", "v" }, "<leader>y", [["+y]], opts)
remap("n", "<leader>Y", [["+Y]], opts)

remap({ "n", "v" }, "<leader>d", [["_d]], opts)

remap("n", "Q", "<C-q>", opts)
remap("n", "<leader>f", vim.lsp.buf.format, opts)

remap("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], opts)
remap("n", "<leader>x", "<cmd>!chmod +x %<CR>", opts)

if vim.g.neovide then
  remap({ "i", "c" }, "<C-BS>", "<C-w>", { noremap = true })
end

