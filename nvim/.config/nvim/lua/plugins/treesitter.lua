return {
    {
        "nvim-treesitter/nvim-treesitter",
        version = nil,
        build = ":TSUpdate",
        priority = 100,
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "python",
                    "go",
                    -- "rust",
                    "html",
                    "javascript",
                    "json",
                    "markdown",
                    "rust",
                    "toml",
                    "tsx",
                    "typescript",
                    "lua",
                    "yaml",
                },
                context_commentstring = {
                    enable = true,
                    enable_autocmd = false,
                },
                autotag = {
                    enable = true,
                },
                auto_install = true,
                -- sync_install = false,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
            })
        end,
        dependencies = {
            { "nvim-treesitter/nvim-treesitter-textobjects" },
        },
    },
    { "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },
    { "nvim-treesitter/nvim-treesitter-context", event = "BufReadPre", config = true },
    { "JoosepAlviste/nvim-ts-context-commentstring" },
}
