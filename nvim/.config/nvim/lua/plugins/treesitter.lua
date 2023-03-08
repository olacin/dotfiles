return {
    { "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },
    { "nvim-treesitter/nvim-treesitter-context", event = "BufReadPre", config = true },
    { "JoosepAlviste/nvim-ts-context-commentstring" },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        opts = {
            ensure_installed = {
                "python",
                "go",
                "rust",
                "html",
                "javascript",
                "json",
                "markdown",
                "rust",
                "toml",
                "tsx",
                "typescript",
                "lua",
                "diff",
                "gitignore",
                "regex",
                "yaml",
            },
            context_commentstring = {
                enable = true
            }
        },
        -- dependencies = {
        --     { "nvim-treesitter/nvim-treesitter-textobjects" },
        -- },
    },
}
