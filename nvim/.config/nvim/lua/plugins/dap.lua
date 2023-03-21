return {
    {
        "mfussenegger/nvim-dap",
        config = function()
            -- Load .vscode/launch.json configurations
            require("dap.ext.vscode").load_launchjs()
        end,
        keys = {
            {
                "<leader>dc",
                function()
                    require("dap").continue()
                end,
                desc = "Continue debugging",
            },
            {
                "<leader>dk",
                function()
                    require("dap").terminate()
                end,
                desc = "Terminate debugging session",
            },
            {
                "<leader>do",
                function()
                    require("dap").step_over()
                end,
                desc = "Step over",
            },
            {
                "<leader>di",
                function()
                    require("dap").step_into()
                end,
                desc = "Step into",
            },
            {
                "<leader>du",
                function()
                    require("dap").step_out()
                end,
                desc = "Step out",
            },
            {
                "<leader>b",
                function()
                    require("dap").toggle_breakpoint()
                end,
                desc = "Toggle breakpoint",
            },
        },
    },
    {
        "leoluz/nvim-dap-go",
        dependencies = { "mfussenegger/nvim-dap" },
        ft = { "go" },
        config = function()
            local dap = require("dap")
            local dap_go = require("dap-go")
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
        end,
    },
    {
        "mfussenegger/nvim-dap-python",
        dependencies = { "mfussenegger/nvim-dap" },
        ft = { "python" },
        config = function()
            local dap_python = require("dap-python")
            dap_python.test_runner = "pytest"
            dap_python.setup("~/.virtualenvs/debugpy/bin/python")
        end,
        keys = {
            {
                "<leader>dt",
                function()
                    require("dap-python").test_method()
                end,
                desc = "Test function",
            },
        },
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap" },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")

            dapui.setup()

            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open({})
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close({})
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close({})
            end
        end,
    },
}
