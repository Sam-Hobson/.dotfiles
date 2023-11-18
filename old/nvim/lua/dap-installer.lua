-- :DIinstall ...


local dap_install = require("dap-install")

vim.fn.sign_define('DapBreakpoint', {text='⊝', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapStopped', {text='➟', texthl='', linehl='', numhl=''})

dap_install.setup({
	installation_path = "/home/sam/.config/nvim/test_dap_install/",
	verbosely_call_debuggers = true,
})

-- Python

--[[ local dap_install = require("dap-install")
dap_install.config("python_dbg", {})

local dap_install = require("dap-install")
dap_install.config(
	"python_dbg",
    {
        adapters = {
            type = "executable",
            command = "python3.9",
            args = {"-m", "debugpy.adapter"}
        },
        configurations = {
            {
                type = "python",
                request = "launch",
                name = "Launch file",
                program = "${file}",
                pythonPath = function()
                    local cwd = vim.fn.getcwd()
                    if vim.fn.executable(cwd .. "/usr/bin/python3.9") == 1 then
                        return cwd .. "/usr/bin/python3.9"
                    elseif vim.fn.executable(cwd .. "/usr/bin/python3.9") == 1 then
                        return cwd .. "/usr/bin/python3.9"
                    else
                        return "/usr/bin/python3.9"
                    end
                end
            }
        }
    }
) ]]


-- C/C++/Rust
--
local dap = require('dap')
dap.adapters.cppdbg = {
  type = 'executable',
  command = '/home/sam/.config/nvim/test_dap_install/ccppr_vsc_dbg/extension/debugAdapters/OpenDebugAD7',
}

local dap = require('dap')
dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "cppdbg",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = true,
  },
  {
    name = 'Attach to gdbserver :1234',
    type = 'cppdbg',
    request = 'launch',
    MIMode = 'gdb',
    miDebuggerServerAddress = 'localhost:1234',
    miDebuggerPath = '/usr/bin/gdb',
    cwd = '${workspaceFolder}',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
  },
}



dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp
