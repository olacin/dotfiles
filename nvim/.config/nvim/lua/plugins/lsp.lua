local disabled_formatters = { "tsserver", "gopls" }

-- Setup mappings on LSP
local on_attach = function(client, bufnr)
    -- local illuminate = require("illuminate")

    if vim.tbl_contains(disabled_formatters, client.name) then
        -- Disable formatting
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
    end

    local opts = { buffer = bufnr }

    -- Enable illuminate
    -- illuminate.on_attach(client)

    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "<leader>dl", "<cmd>Telescope diagnostics<CR>", opts)
    vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts)
end

return {
    { "folke/neodev.nvim" },
    { "williamboman/mason.nvim", config = true },
    {
        "williamboman/mason-lspconfig.nvim",
        opts = {
            ensure_installed = {
                "gopls",
                "pyright",
                "lua_ls",
                "rust_analyzer",
                "tsserver",
                "tailwindcss",
            },
        },
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            local lspconfig = require("lspconfig")
            local mason_lspconfig = require("mason-lspconfig")
            local cmp_nvim_lsp = require("cmp_nvim_lsp")

            for _, server in pairs(mason_lspconfig.get_installed_servers()) do
                if server == "lua_ls" then
                    lspconfig[server].setup({
                        capabilities = cmp_nvim_lsp.default_capabilities(),
                        on_attach = on_attach,
                        settings = { Lua = { diagnostics = { globals = { "vim" } } } },
                    })
                else
                    lspconfig[server].setup({
                        capabilities = cmp_nvim_lsp.default_capabilities(),
                        on_attach = on_attach,
                    })
                end
            end
        end,
    },
    {
        "ray-x/lsp_signature.nvim",
        opts = {
            bind = true,
            handler_opts = {
                border = "rounded",
            },
        },
    },
    {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
            local null_ls = require("null-ls")
            local formatting = null_ls.builtins.formatting
            local diagnostics = null_ls.builtins.diagnostics
            local code_actions = null_ls.builtins.code_actions
            null_ls.setup({
                -- debug = true,
                sources = {
                    -- Python
                    diagnostics.ruff,
                    -- diagnostics.flake8.with({ extra_args = { "--max-line-length", "88" } }),
                    formatting.black,
                    formatting.isort.with({
                        extra_args = {
                            "--profile",
                            "black",
                            "--order-by-type",
                            "--multi-line",
                            "3",
                            "--trailing-comma",
                            "--use-parentheses",
                        },
                        prefer_local = ".venv/bin",
                    }),
                    -- Typescript
                    diagnostics.eslint_d,
                    code_actions.eslint_d,
                    formatting.prettier.with({
                        filetypes = {
                            "javascript",
                            "javascriptreact",
                            "typescript",
                            "typescriptreact",
                            "vue",
                            "css",
                            "scss",
                            "less",
                            "html",
                            "json",
                            "jsonc",
                            -- "markdown",
                            "yaml",
                            "graphql",
                            "handlebars",
                        },
                    }),
                    -- Lua
                    formatting.stylua,
                    -- Go
                    formatting.gofmt,
                    -- Rust
                    formatting.rustfmt.with({
                        extra_args = {
                            "--edition",
                            "2021",
                        },
                    }),
                },
                on_attach = function(client)
                    if client.server_capabilities.documentFormattingProvider then
                        local group = vim.api.nvim_create_augroup("LspFormatting", { clear = true })
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            callback = function()
                                vim.lsp.buf.format({
                                    filter = function(c)
                                        return not vim.tbl_contains({ "tsserver", "gopls" }, c.name)
                                    end,
                                })
                            end,
                            group = group,
                        })
                    end
                end,
            })
        end,
    },
    {
        "j-hui/fidget.nvim",
        opts = {
            { text = { spinner = "pipe" } },
        },
    },
}
