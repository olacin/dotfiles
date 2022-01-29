null_ls = require('null-ls')

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
	sources = {
		-- Python
		diagnostics.flake8.with { extra_args = { "--max-line-length", "88"} },
		formatting.black,
		formatting.isort.with { extra_args = { "--profile", "black" } },
		-- Typescript
		null_ls.builtins.formatting.eslint_d,
		null_ls.builtins.formatting.prettier,
		-- Lua
		null_ls.builtins.formatting.stylua
	},
	on_attach = function(client)
        if client.resolved_capabilities.document_formatting then
            vim.cmd([[
            augroup LspFormatting
                autocmd! * <buffer>
                autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
            augroup END
            ]])
        end
    end,
})
