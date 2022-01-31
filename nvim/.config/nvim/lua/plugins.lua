return require("packer").startup(function()
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	-- Theme
	use("gruvbox-community/gruvbox")

	-- LSP
	use({
		"neovim/nvim-lspconfig",
		config = require("config/nvim-lspconfig"),
	})

	-- Autocompletion
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-cmdline")
	use({ "hrsh7th/nvim-cmp", config = require("config/nvim-cmp") })
	use("L3MON4D3/LuaSnip")

	-- Formatting
	use({
		"jose-elias-alvarez/null-ls.nvim",
		config = require("config/null-ls"),
	})

	-- Telescope
	use({
		"nvim-telescope/telescope.nvim",
		requires = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } },
		config = require("config/telescope"),
	})
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
	use("olacin/telescope-gitmoji.nvim")
	use("jvgrootveld/telescope-zoxide")

	-- Utils
	use("tpope/vim-surround")
	use("tpope/vim-commentary")
	use("tpope/vim-fugitive")

	-- Statusline
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
		config = require("config/lualine"),
	})

	-- TreeSitter
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })

	-- Docstrings
	use({ "kkoomen/vim-doge", run = ":call doge#install()" })

	-- Autopairs
	use({
		"windwp/nvim-autopairs",
		config = require("config/autopairs"),
	})
	use({
		"windwp/nvim-ts-autotag",
		config = require("config/autotag"),
	})
end)
