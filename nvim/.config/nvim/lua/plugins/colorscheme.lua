return {
    { "ellisonleao/gruvbox.nvim" },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
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
        end
    },
}
