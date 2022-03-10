local ok, dap = pcall(require, "dap")
if not ok then
    return
end

local dapui = require("dapui")
local dap_python = require("dap-python")
local dap_go = require("dap-go")

dapui.setup({
    sidebar = {
        elements = {
            { id = "scopes", size = 0.5 },
            { id = "breakpoints", size = 0.25 },
            { id = "watches", size = 0.25 },
        },
    },
})

-- Setup Python
dap_python.test_runner = "pytest"
dap_python.setup("~/.virtualenvs/debugpy/bin/python")

-- Setup Go
dap_go.setup()
table.insert(dap.configurations.go, {
    type = "go",
    name = "Debug file with arguments",
    request = "launch",
    program = "${file}",
    args = function()
        local args_string = vim.fn.input("Arguments: ")
        return vim.split(args_string, " +")
    end,
})

-- Load .vscode/launch.json configurations
require("dap.ext.vscode").load_launchjs()

dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end
