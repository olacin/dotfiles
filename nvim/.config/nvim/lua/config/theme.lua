import("tokyonight", function(tokyonight)
    tokyonight.setup({
        style = "moon",
        styles = {
            comments = { italic = true },
            keywords = { italic = true },
            functions = {},
            variables = {},
        },
        lualine_bold = true,
    })
end)
