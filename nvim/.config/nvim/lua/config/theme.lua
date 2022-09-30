local ok, tokyonight = pcall(require, "tokyonight")
if not ok then
    return
end

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
