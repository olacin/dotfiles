-- Important: must be before lspconfig
local neodev = require("neodev")
neodev.setup()

local lspconfig = require("lspconfig")
local cmp_nvim_lsp = require("cmp_nvim_lsp")
local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local lsp_signature = require("lsp_signature")
local illuminate = require("illuminate")

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

-- Setup mappings on LSP
local on_attach = function(client, bufnr)
    if vim.tbl_contains(disabled_formatters, client.name) then
        -- Disable formatting
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
        -- Enable illuminate
        illuminate.on_attach(client)
    end

    local opts = { buffer = bufnr }

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

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
})
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
})

-- Setup mason.nvim
mason.setup()
mason_lspconfig.setup({
    ensure_installed = {
        "gopls",
        "pyright",
        "sumneko_lua",
        "rust_analyzer",
        "tsserver",
        "tailwindcss",
    },
})

for _, server in ipairs(mason_lspconfig.get_installed_servers()) do
    lspconfig[server].setup({
        capabilities = cmp_nvim_lsp.default_capabilities(),
        on_attach = on_attach,
    })
end

vim.diagnostic.config({
    virtual_text = true,
})
