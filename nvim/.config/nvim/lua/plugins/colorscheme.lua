return {
    {
        "sainnhe/gruvbox-material",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd([[colorscheme gruvbox-material]])
        end,
    },
    {
        "folke/tokyonight.nvim",
        enabled = false,
        lazy = false,
        -- priority = 1000,
        config = function()
            require("tokyonight").setup({
                style = "moon",
                styles = {
                    comments = { italic = true },
                    keywords = { italic = true },
                    functions = {},
                    variables = {},
                },
                lualine_bold = true,
            })
            vim.cmd([[colorscheme tokyonight]])
        end,
    },
}
