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
        formatting.black.with({ extra_args = { "--fast" } }),
        formatting.isort.with({ extra_args = { "--profile", "black" } }),
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
        if client.server_capabilities.document_formatting then
            local group = vim.api.nvim_create_augroup("LspFormatting", { clear = true })
            vim.api.nvim_create_autocmd("BufWritePre", { command = "lua vim.lsp.buf.formatting_sync()", group = group })
        end
    end,
})
