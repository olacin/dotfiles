-- Important: must be before lspconfig
import("neodev", function(neodev)
    neodev.setup()
end)

import({ "lspconfig", "cmp_nvim_lsp", "mason", "mason-lspconfig", "lsp_signature", "illuminate" }, function(modules)
    local signs = { Error = "E ", Warn = "W ", Hint = "H ", Info = "I " }
    for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end

    -- Attach LSP signature
    modules.lsp_signature.setup({
        bind = true,
        handler_opts = {
            border = "rounded",
        },
    })

    local disabled_formatters = { "tsserver", "gopls" }

    -- Setup mappings on LSP
    local on_attach = function(client, bufnr)
        if vim.tbl_contains(disabled_formatters, client.name) then
            -- Disable formatting
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
            -- Enable illuminate
            modules.illuminate.on_attach(client)
        end

        vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr })
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr })
        vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { buffer = bufnr })
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = bufnr })
        vim.keymap.set("n", "<leader>dj", vim.diagnostic.goto_next, { buffer = bufnr })
        vim.keymap.set("n", "<leader>dk", vim.diagnostic.goto_prev, { buffer = bufnr })
        vim.keymap.set("n", "<leader>dl", "<cmd>Telescope diagnostics<CR>", { buffer = bufnr })
        vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { buffer = bufnr })
    end

    -- Setup mason.nvim
    modules.mason.setup()
    modules["mason-lspconfig"].setup({
        ensure_installed = {
            "gopls",
            "pyright",
            "sumneko_lua",
            "rust_analyzer",
            "tsserver",
            "tailwindcss",
        },
    })

    for _, server in ipairs(modules["mason-lspconfig"].get_installed_servers()) do
        modules.lspconfig[server].setup({
            capabilities = modules["cmp_nvim_lsp"].default_capabilities(),
            on_attach = on_attach,
        })
    end
end)
