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
      text = "B",
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

    dap.adapters.python = function(cb, config)
      if config.request == "attach" then
        ---@diagnostic disable-next-line: undefined-field
        local port = (config.connect or config).port

        ---@diagnostic disable-next-line: undefined-field
        local host = (config.connect or config).host or "127.0.0.1"

        cb({
          type = "server",
          port = assert(port, "`connect.port` is required for a python `attach` configuration"),
          host = host,
          options = {
            source_filetype = "python",
          },
        })

      else
        cb({
          type = "executable",
          command = "python",
          args = { "-m", "debugpy.adapter" },
          options = {
            source_filetype = "python",
          },
        })
      end
    end

    dap.configurations.python = {{
        -- The first three options are required by nvim-dap
        type = "python"; -- the type here established the link to the adapter definition: `dap.adapters.python`
        request = "launch";
        name = "Launch file";

        -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options
        program = "${file}"; -- This configuration will launch the current file if used.

        pythonPath = function()
          -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
          -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
          -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
          local cwd = vim.fn.getcwd()
          if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
            return cwd .. "/venv/bin/python"
          elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
            return cwd .. "/.venv/bin/python"
          else
            return "python"
          end
        end;
      }
    }
  end,
}
