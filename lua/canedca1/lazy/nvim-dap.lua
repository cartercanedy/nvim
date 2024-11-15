local opts = {
  silent = true,
  noremap = true
}

return {
  "mfussenegger/nvim-dap",
  init = function()
    local dap = require("dap")
    local widgets = require("dap.ui.widgets")

    vim.fn.sign_define("DapBreakpoint", {
      text = "🔴",
      texthl = "",
      linehl = "",
      numhl = ""
    })

    local remap = vim.keymap.set

    remap("n", "<leader>dp", dap.toggle_breakpoint, opts)
    remap(
      "n",
      "<leader>dl",
      function()
        dap.set_breakpoint(
          nil,
          nil,
          vim.fn.input("Log point message: ")
        )
      end
    )

    remap("n", "<leader>dc", dap.continue, opts)
    remap("n", "<leader>dso", dap.step_over, opts)
    remap("n", "<leader>dsO", dap.step_out, opts)
    remap("n", "<leader>dsi", dap.step_into, opts)
    remap("n", "<leader>dui", dap.repl.open, opts)
    remap("n", "<C-S-k>", widgets.hover, opts)

    dap.adapters.coreclr = {
      type = "executable",
      command = "netcoredbg",
      args = { "--interpreter=vscode" }
    }

    dap.configurations.cs = {{
      type = "coreclr",
      name = "launch - netcoredbg",
      request = "launch",
      program = function()
        return vim.fn.input(
          "Path to dll: ",
          vim.fn.getcwd() .. "/bin/Debug/",
          "file"
        )
      end
    }}
  end,
}
