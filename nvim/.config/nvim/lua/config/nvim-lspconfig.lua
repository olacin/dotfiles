local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

local on_attach = function(client, bufnr)
	-- Disable formatting for tsserver
	if client.name == "tsserver" then
		client.resolved_capabilities.document_formatting = false
		client.resolved_capabilities.document_range_formatting = false
	end

	-- Mappings.
	vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = 0 })
	vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { buffer = 0 })
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = 0 })
	vim.keymap.set("n", "<leader>dj", vim.diagnostic.goto_next, { buffer = 0 })
	vim.keymap.set("n", "<leader>dk", vim.diagnostic.goto_prev, { buffer = 0 })
	vim.keymap.set("n", "<leader>dl", "<cmd>Telescope diagnostics<CR>", { buffer = 0 })
	vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { buffer = 0 })
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { "pyright", "tsserver", "gopls" }
for _, lsp in pairs(servers) do
	require("lspconfig")[lsp].setup({
		capabilities = capabilities,
		on_attach = on_attach,
	})
end
