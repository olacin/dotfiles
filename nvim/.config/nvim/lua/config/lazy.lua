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

--     -- Treesitter
--     {
--         "nvim-treesitter/nvim-treesitter",
--         build = ":TSUpdate",
--         dependencies = {
--             { "nvim-treesitter/nvim-treesitter-textobjects" },
--             { "nvim-treesitter/playground" },
--             { "JoosepAlviste/nvim-ts-context-commentstring" },
--             { "nvim-treesitter/nvim-treesitter-context" },
--         },
--     },
--
--     -- LSP
--     {
--         "neovim/nvim-lspconfig",
--         dependencies = {
--             "williamboman/mason.nvim",
--             "williamboman/mason-lspconfig.nvim",
--             "ray-x/lsp_signature.nvim",
--             "RRethy/vim-illuminate",
--             "folke/neodev.nvim",
--         },
--     },
--     "j-hui/fidget.nvim",
--     {
--         "folke/trouble.nvim",
--         dependencies = {
--             { "kyazdani42/nvim-web-devicons" },
--             { "folke/todo-comments.nvim" },
--         },
--     },
--     "folke/lsp-colors.nvim",
--
--     -- Autocompletion
--     {
--         "hrsh7th/nvim-cmp",
--         dependencies = {
--             { "hrsh7th/cmp-nvim-lsp" },
--             { "hrsh7th/cmp-buffer" },
--             { "hrsh7th/cmp-path" },
--             { "hrsh7th/cmp-nvim-lua" },
--             { "L3MON4D3/LuaSnip" },
--             { "saadparwaiz1/cmp_luasnip" },
--             { "rafamadriz/friendly-snippets" },
--             { "onsails/lspkind-nvim" },
--         },
--     },
--     {
--         "tzachar/cmp-tabnine",
--         build = "./install.sh",
--         dependencies = "hrsh7th/nvim-cmp",
--     },
--
--     -- Formatting
--     {
--         "jose-elias-alvarez/null-ls.nvim",
--     },
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
--     -- Telescope
--     {
--         "nvim-telescope/telescope.nvim",
--         dependencies = {
--             { "nvim-lua/popup.nvim" },
--             { "nvim-lua/plenary.nvim" },
--             { "nvim-telescope/telescope-file-browser.nvim" },
--             { "nvim-telescope/telescope-symbols.nvim" },
--             { "olacin/telescope-gitmoji.nvim" },
--             { "olacin/telescope-cc.nvim" },
--         },
--     },
--     { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
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
--     -- Statusline
--     {
--         "nvim-lualine/lualine.nvim",
--         dependencies = { "kyazdani42/nvim-web-devicons", opt = true },
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
--     "stevearc/dressing.nvim",
-- }, { defaults = { lazy = true } })
