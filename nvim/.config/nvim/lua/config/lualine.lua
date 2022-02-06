local ok, lualine = pcall(require, "lualine")
if not ok then
    return
end

lualine.setup({
    options = {
        icons_enabled = true,
        component_separators = "|",
        section_separators = "",
        theme = "gruvbox_dark",
    },
    sections = {
        lualine_b = { "branch" },
        lualine_c = {
            {
                "diagnostics",
                sources = { "nvim_diagnostic" },
                symbols = { error = "E", warn = "W", info = "I", hint = "H" },
            },
        },
        lualine_x = { "encoding" },
        lualine_y = { "filetype" },
        lualine_z = {
            {
                "fileformat",
                symbols = {
                    unix = "LF",
                    dos = "CRLF",
                    mac = "CR",
                },
            },
        },
    },
})
