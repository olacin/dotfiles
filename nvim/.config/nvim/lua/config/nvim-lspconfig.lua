local cmp_ok, cmp = pcall(require, "cmp_nvim_lsp")
if not cmp_ok then
    return
end

local ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not ok then
    return
end

local capabilities = cmp.update_capabilities(vim.lsp.protocol.make_client_capabilities())

local signs = { Error = "E ", Warn = "W ", Hint = "H ", Info = "I " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local function contains(tbl, val)
    for _, value in ipairs(tbl) do
        if value == val then
            return true
        end
    end
    return false
end

local disabled_formatters = { "tsserver", "gopls" }

local on_attach = function(client, bufnr)
    if contains(disabled_formatters, client.name) then
        -- Disable formatting
        client.server_capabilities.document_formatting = false
        client.server_capabilities.document_range_formatting = false
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

lsp_installer.on_server_ready(function(server)
    local opts = {
        capabilities = capabilities,
        on_attach = on_attach,
    }

    if server.name == "sumneko_lua" then
        opts.settings = {
            Lua = {
                diagnostics = {
                    globals = { "vim", "awesome", "client", "screen", "root" },
                },
            },
        }
    end

    server:setup(opts)
end)
