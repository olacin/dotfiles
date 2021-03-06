local ok, cmp = pcall(require, "cmp")
if not ok then
    return
end

local luasnip = require("luasnip")
local lspkind = require("lspkind")

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "path" },
        { name = "cmp_tabnine" },
        { name = "nvim_lua" },
        { name = "buffer" },
    }),
    formatting = {
        format = lspkind.cmp_format({
            mode = "symbol",
            menu = {
                buffer = "[buf]",
                nvim_lsp = "[LSP]",
                nvim_lua = "[api]",
                path = "[path]",
                luasnip = "[snip]",
                cmp_tabnine = "[tab9]",
            },
        }),
    },
    experimental = {
        native_menu = false,
        ghost_text = true,
    },
})

luasnip.config.set_config({
    history = true,
    updateevents = "TextChanged,TextChangedI",
})

require("luasnip.loaders.from_vscode").lazy_load()

local s = luasnip.snippet
local i = luasnip.insert_node
local f = luasnip.function_node
local fmt = require("luasnip.extras.fmt").fmt

local copy = function(args)
    return args[1]
end

luasnip.add_snippets("python", {
    s(
        "test",
        fmt(
            [[
        @pytest.mark.parametrize(
            "{}",
            []
        )
        def test_{}({}):
            pass
        ]]   ,
            { i(1), i(2), f(copy, 1) }
        )
    ),
})

luasnip.add_snippets("go", {
    s(
        "iferr",
        fmt(
            [[
        if err != nil {{
            {}
        }}
        ]]   ,
            { i(1) }
        )
    ),
})
