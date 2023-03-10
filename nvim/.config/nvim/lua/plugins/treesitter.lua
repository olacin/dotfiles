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
                sync_install = false,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true,
                        keymaps = {
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            ["ic"] = "@class.inner",
                        },
                    },
                    move = {
                        enable = true,
                        set_jumps = true,
                        goto_next_start = {
                            ["]m"] = "@function.outer",
                            ["]]"] = "@class.outer",
                        },
                        goto_next_end = {
                            ["]M"] = "@function.outer",
                            ["]["] = "@class.outer",
                        },
                        goto_previous_start = {
                            ["[m"] = "@function.outer",
                            ["[["] = "@class.outer",
                        },
                        goto_previous_end = {
                            ["[M"] = "@function.outer",
                            ["[]"] = "@class.outer",
                        },
                    },
                },
            })
        end,
        dependencies = {
            { "nvim-treesitter/nvim-treesitter-textobjects" },
        },
    },
    {
        "nvim-treesitter/playground",
        cmd = "TSPlaygroundToggle",
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        event = "BufReadPre",
        config = true,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        opts = {
            buftype_exclude = { "terminal", "telescope", "nofile" },
            filetype_exclude = { "help", "dashboard", "lazy", "Trouble", "TelescopePrompt", "Float" },
            show_current_context = true,
            show_current_context_start = false,
            space_char_blankline = " ",
            use_treesitter = true,
        },
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
    },
    {
        "danymat/neogen",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        config = true,
        keys = {
            {
                "<leader>d",
                function()
                    require("neogen").generate()
                end,
                desc = "Generate documentation",
            },
        },
    },
    {
        "numToStr/Comment.nvim",
        dependencies = {
            "JoosepAlviste/nvim-ts-context-commentstring",
        },
        config = function()
            require("Comment").setup({
                pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
            })
        end,
    },
}
