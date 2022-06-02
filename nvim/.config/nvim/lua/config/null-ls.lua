local ok, null_ls = pcall(require, "null-ls")
if not ok then
    return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

null_ls.setup({
    debug = true,
    sources = {
        -- Python
        diagnostics.flake8.with({ extra_args = { "--max-line-length", "88" } }),
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
