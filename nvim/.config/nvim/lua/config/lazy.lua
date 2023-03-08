-- Automaticaly install lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

return function(opts)
    opts = vim.tbl_extend("force", {
        defaults = { lazy = true },
        import = "plugins",
        install = {
            colorscheme = { "tokyonight" },
        },
    }, opts or {})
    require("lazy").setup(opts)
end

--     {
--         "folke/trouble.nvim",
--         dependencies = {
--             { "kyazdani42/nvim-web-devicons" },
--             { "folke/todo-comments.nvim" },
--         },
--     },
--     "folke/lsp-colors.nvim",
--
--     {
--         "tzachar/cmp-tabnine",
--         build = "./install.sh",
--         dependencies = "hrsh7th/nvim-cmp",
--     },
--
--
--     -- Debugging
--     {
--         "mfussenegger/nvim-dap",
--         dependencies = {
--             { "mfussenegger/nvim-dap-python" },
--             { "leoluz/nvim-dap-go" },
--             { "rcarriga/nvim-dap-ui" },
--         },
--     },
--
--     -- Git
--     "tpope/vim-fugitive",
--     "TimUntersberger/neogit",
--     "sindrets/diffview.nvim",
--     {
--         "lewis6991/gitsigns.nvim",
--         dependencies = {
--             "nvim-lua/plenary.nvim",
--         },
--     },
--
--     -- Docstrings
--     {
--         "danymat/neogen",
--         dependencies = "nvim-treesitter/nvim-treesitter",
--     },
--
--     -- Misc
--     "tpope/vim-surround",
--     "ThePrimeagen/harpoon",
--     "numToStr/Comment.nvim",
--     "windwp/nvim-autopairs",
--     "windwp/nvim-ts-autotag",
--     "lukas-reineke/indent-blankline.nvim",
-- }, { defaults = { lazy = true } })
