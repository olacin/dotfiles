local fn = vim.fn

-- Automaticaly install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })
    print("Installing packer...")
end

local group = vim.api.nvim_create_augroup("packer_user_config", { clear = true })
vim.api.nvim_create_autocmd(
    "BufWritePost",
    { pattern = "plugins.lua", command = "source <afile> | PackerSync", group = group }
)

local ok, packer = pcall(require, "packer")
if not ok then
    return
end

return packer.startup(function(use)
    use("wbthomason/packer.nvim") -- Packer
    use("lewis6991/impatient.nvim") -- Impatient
    use("dstein64/vim-startuptime") -- StartupTime
    use("ellisonleao/gruvbox.nvim") -- Theme
    use("folke/tokyonight.nvim")

    -- Treesitter
    use({
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        requires = {
            { "nvim-treesitter/nvim-treesitter-textobjects" },
            { "nvim-treesitter/playground" },
            { "JoosepAlviste/nvim-ts-context-commentstring" },
        },
        config = require("config.treesitter"),
    })

    -- LSP
    use({
        "neovim/nvim-lspconfig",
        requires = {
            { "williamboman/nvim-lsp-installer" },
        },
        config = require("config.nvim-lspconfig"),
    })
    use({ "j-hui/fidget.nvim", config = require("config.fidget") })
    use({
        "folke/trouble.nvim",
        requires = {
            { "kyazdani42/nvim-web-devicons" },
            { "folke/todo-comments.nvim" },
        },
        config = require("config.trouble"),
    })
    use("folke/lsp-colors.nvim")

    -- Autocompletion
    use({
        "hrsh7th/nvim-cmp",
        requires = {
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-path" },
            { "hrsh7th/cmp-nvim-lua" },
            { "L3MON4D3/LuaSnip" },
            { "saadparwaiz1/cmp_luasnip" },
            { "rafamadriz/friendly-snippets" },
            { "onsails/lspkind-nvim" },
        },
        config = require("config.nvim-cmp"),
    })

    -- Formatting
    use({
        "jose-elias-alvarez/null-ls.nvim",
        config = require("config.null-ls"),
    })

    -- Debugging
    use({
        "mfussenegger/nvim-dap",
        requires = {
            { "mfussenegger/nvim-dap-python" },
            { "leoluz/nvim-dap-go" },
            { "rcarriga/nvim-dap-ui" },
        },
        config = require("config.dap"),
    })

    -- Telescope
    use({
        "nvim-telescope/telescope.nvim",
        requires = {
            { "nvim-lua/popup.nvim" },
            { "nvim-lua/plenary.nvim" },
            { "nvim-telescope/telescope-file-browser.nvim" },
            { "olacin/telescope-gitmoji.nvim" },
        },
        config = require("config.telescope"),
    })
    use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

    -- Git
    use("tpope/vim-fugitive")
    use({
        "lewis6991/gitsigns.nvim",
        requires = {
            "nvim-lua/plenary.nvim",
        },
        config = require("config.gitsigns"),
    })

    -- Statusline
    use({
        "nvim-lualine/lualine.nvim",
        requires = { "kyazdani42/nvim-web-devicons", opt = true },
        config = require("config.lualine"),
    })

    -- Docstrings
    use({
        "danymat/neogen",
        config = require("config.neogen"),
        requires = "nvim-treesitter/nvim-treesitter",
    })

    -- Misc
    use("tpope/vim-surround")
    use({
        "numToStr/Comment.nvim",
        config = require("config.comment"),
    })
    use({
        "windwp/nvim-autopairs",
        config = require("config.autopairs"),
    })
    use({
        "windwp/nvim-ts-autotag",
        config = require("config.autotag"),
    })
    use({
        "lukas-reineke/indent-blankline.nvim",
        config = require("config.indent"),
    })

    if packer_bootstrap then
        require("packer").sync()
    end
end)
