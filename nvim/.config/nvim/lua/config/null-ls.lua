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
        formatting.isort,
        -- Typescript
        diagnostics.eslint_d,
        code_actions.eslint_d,
        formatting.prettier,
        -- Lua
        formatting.stylua,
        -- Go
        formatting.gofmt,
    },
    on_attach = function(client)
        if client.resolved_capabilities.document_formatting then
            local group = vim.api.nvim_create_augroup("LspFormatting", { clear = true })
            vim.api.nvim_create_autocmd("BufWritePre", { command = "lua vim.lsp.buf.formatting_sync()", group = group })
        end
    end,
})
