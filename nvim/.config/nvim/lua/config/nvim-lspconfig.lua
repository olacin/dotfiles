local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_ok then
    return
end

local cmp_ok, cmp = pcall(require, "cmp_nvim_lsp")
if not cmp_ok then
    return
end

local ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not ok then
    return
end

local lsp_signature_ok, lsp_signature = pcall(require, "lsp_signature")
if not lsp_signature_ok then
    return
end

local illuminate_ok, illuminate = pcall(require, "illuminate")
if not illuminate_ok then
    return
end

local luadev_ok, lua_dev = pcall(require, "lua-dev")
if not luadev_ok then
    return
end

local signs = { Error = "E ", Warn = "W ", Hint = "H ", Info = "I " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Attach LSP signature
lsp_signature.setup({
    bind = true,
    handler_opts = {
        border = "rounded",
    },
})

local disabled_formatters = { "tsserver", "gopls" }

local on_attach = function(client, bufnr)
    if vim.tbl_contains(disabled_formatters, client.name) then
        -- Disable formatting
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
        -- Enable illuminate
        illuminate.on_attach(client)
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

local capabilities = vim.lsp.protocol.make_client_capabilities()

-- Setup LSP installer
lsp_installer.setup({})

for _, server in ipairs(lsp_installer.get_installed_servers()) do
    local opts = {
        capabilities = cmp.update_capabilities(capabilities),
        on_attach = on_attach,
    }
    if server.name == "sumneko_lua" then
        lspconfig[server.name].setup(lua_dev.setup({
            lspconfig = opts,
        }))
    else
        lspconfig[server.name].setup(opts)
    end
end
