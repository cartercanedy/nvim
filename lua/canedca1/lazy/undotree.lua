return {
  "mbbill/undotree",
  config = function()
    vim.keymap.set("n", "<Space>u", vim.cmd.UndotreeToggle)
  end
}
