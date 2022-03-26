local fn = vim.fn

-- Automaticaly install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    Packer_bootstrap = fn.system({
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

packer.init({
    display = {
        open_fn = function()
            return require("packer.util").float({ border = "rounded" })
        end,
    },
})

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
    })

    -- LSP
    use({
        "neovim/nvim-lspconfig",
        requires = {
            { "williamboman/nvim-lsp-installer" },
        },
    })
    use({ "j-hui/fidget.nvim" })
    use({
        "folke/trouble.nvim",
        requires = {
            { "kyazdani42/nvim-web-devicons" },
            { "folke/todo-comments.nvim" },
        },
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
    })

    -- Formatting
    use({
        "jose-elias-alvarez/null-ls.nvim",
    })

    -- Debugging
    use({
        "mfussenegger/nvim-dap",
        requires = {
            { "mfussenegger/nvim-dap-python" },
            { "leoluz/nvim-dap-go" },
            { "rcarriga/nvim-dap-ui" },
        },
    })

    -- Telescope
    use({
        "nvim-telescope/telescope.nvim",
        requires = {
            { "nvim-lua/popup.nvim" },
            { "nvim-lua/plenary.nvim" },
            { "nvim-telescope/telescope-file-browser.nvim" },
            { "nvim-telescope/telescope-symbols.nvim" },
            { "olacin/telescope-gitmoji.nvim" },
            { "olacin/telescope-cc.nvim" },
        },
    })
    use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

    -- Git
    use("tpope/vim-fugitive")
    use({
        "lewis6991/gitsigns.nvim",
        requires = {
            "nvim-lua/plenary.nvim",
        },
    })

    -- Statusline
    use({
        "nvim-lualine/lualine.nvim",
        requires = { "kyazdani42/nvim-web-devicons", opt = true },
    })

    -- Docstrings
    use({
        "danymat/neogen",
        requires = "nvim-treesitter/nvim-treesitter",
    })

    -- Misc
    use("tpope/vim-surround")
    use({
        "numToStr/Comment.nvim",
    })
    use({
        "windwp/nvim-autopairs",
    })
    use({
        "windwp/nvim-ts-autotag",
    })
    use({
        "lukas-reineke/indent-blankline.nvim",
    })
    use({ "stevearc/dressing.nvim" })

    if Packer_bootstrap then
        require("packer").sync()
    end
end)
