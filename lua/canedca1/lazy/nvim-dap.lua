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

    local map_keys = vim.keymap.set

    map_keys("n", "<space>dp", dap.toggle_breakpoint, opts)
    map_keys(
      "n",
      "<space>dl",
      function()
        dap.set_breakpoint(
          nil,
          nil,
          vim.fn.input("Log point message: ")
        )
      end
    )

    map_keys("n", "<space>dc", dap.continue, opts)
    map_keys("n", "<space>dso", dap.step_over, opts)
    map_keys("n", "<space>dsO", dap.step_out, opts)
    map_keys("n", "<space>dsi", dap.step_into, opts)
    map_keys("n", "<space>dui", dap.repl.open, opts)
    map_keys("n", "<C-S-k>", widgets.hover, opts)

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
