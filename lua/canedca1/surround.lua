local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true }

---@type string[]
local brackets = { "()", "{}", "[]", "<>" }
for _, bracket in ipairs(brackets) do
  local l = bracket:sub(1, 1)
  local r = bracket:sub(2, 2)

  keymap("v", "<leader>s" .. l, "c" .. l .. "<Esc>pa" .. r, opts)
  keymap("v", "<leader>s" .. r, "c" .. l .. "<Esc>pa" .. r, opts)
end
