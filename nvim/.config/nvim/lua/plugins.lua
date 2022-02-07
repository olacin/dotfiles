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

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

local ok, packer = pcall(require, "packer")
if not ok then
    return
end

return packer.startup(function(use)
    use("wbthomason/packer.nvim") -- Packer
    use("ellisonleao/gruvbox.nvim") -- Theme
    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }) -- TreeSitter

    -- LSP
    use({
        "neovim/nvim-lspconfig",
        config = require("config/nvim-lspconfig"),
    })
    use({ "j-hui/fidget.nvim", config = require("config/fidget") })

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
        config = require("config/nvim-cmp"),
    })

    -- Formatting
    use({
        "jose-elias-alvarez/null-ls.nvim",
        config = require("config/null-ls"),
    })

    -- Telescope
    use({
        "nvim-telescope/telescope.nvim",
        requires = {
            { "nvim-lua/popup.nvim" },
            { "nvim-lua/plenary.nvim" },
            { "olacin/telescope-gitmoji.nvim" },
        },
        config = require("config/telescope"),
    })
    use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

    -- Git
    use("tpope/vim-fugitive")
    use({
        "lewis6991/gitsigns.nvim",
        requires = {
            "nvim-lua/plenary.nvim",
        },
        config = require("config/gitsigns"),
    })

    -- Statusline
    use({
        "nvim-lualine/lualine.nvim",
        requires = { "kyazdani42/nvim-web-devicons", opt = true },
        config = require("config/lualine"),
    })

    -- Docstrings
    use({
        "danymat/neogen",
        config = require("config/neogen"),
        requires = "nvim-treesitter/nvim-treesitter",
    })

    -- Misc
    use("tpope/vim-surround")
    use({
        "numToStr/Comment.nvim",
        config = require("config/comment"),
    })
    use({
        "windwp/nvim-autopairs",
        config = require("config/autopairs"),
    })
    use({
        "windwp/nvim-ts-autotag",
        config = require("config/autotag"),
    })

    if packer_bootstrap then
        require("packer").sync()
    end
end)
