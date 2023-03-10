return {
    {
        "tpope/vim-fugitive",
        cmd = { "Git", "G" },
    },
    {
        "sindrets/diffview.nvim",
        config = true,
        dependencies = { "nvim-lua/plenary.nvim" },
    },
    {
        "lewis6991/gitsigns.nvim",
        opts = {
            signcolumn = true,
            numhl = true,
            current_line_blame = true,
        },
    },
}
