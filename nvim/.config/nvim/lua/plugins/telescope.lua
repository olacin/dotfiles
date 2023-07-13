local function with_theme(rhs)
    local themes = require("telescope.themes")

    return function()
        return rhs(themes.get_dropdown({}))
    end
end

local function builtin_fn(name)
    local builtin = require("telescope.builtin")
    return with_theme(builtin[name])
end

local function create_conventional_commit()
    local actions = require("telescope._extensions.conventional_commits.actions")
    local picker = require("telescope._extensions.conventional_commits.picker")

    picker({
        action = actions.prompt,
        include_body_and_footer = false,
    })
end

return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-lua/popup.nvim",
        },
        config = function()
            local actions = require("telescope.actions")
            local sorters = require("telescope.sorters")

            require("telescope").setup({
                defaults = {
                    file_ignore_patterns = { "node_modules", ".venv" },
                    mappings = {
                        i = {
                            ["<esc>"] = actions.close,
                            ["<C-j>"] = actions.move_selection_next,
                            ["<C-k>"] = actions.move_selection_previous,
                        },
                    },
                    prompt_prefix = "  ",
                    selection_caret = " ",
                    entry_prefix = "  ",
                    file_sorter = sorters.get_fzf_sorter,
                    generic_sorter = sorters.get_fzf_sorter,
                    color_devicons = true,
                    set_env = { ["COLORTERM"] = "truecolor" },
                }
            })
        end,
        -- Mappings
        keys = {
            {
                "<leader>fb",
                function() builtin_fn("buffers")() end,
                desc = "Find open buffers"
            },
            {
                "<leader>ff",
                function() builtin_fn("find_files")() end,
                desc = "Find files"
            },
            {
                "<leader>ft",
                function() builtin_fn("git_files")() end,
                desc = "Find git files"
            },
            {
                "<leader>fg",
                function() builtin_fn("live_grep")() end,
                desc = "Live grep"
            },
            {
                "<leader>fh",
                function() builtin_fn("help_tags")() end,
                desc = "Help tags"
            },
            {
                "<leader>gw",
                function() builtin_fn("grep_string")() end,
                desc = "Grep string"
            },
            {
                "<leader>gb",
                function() builtin_fn("git_branches")() end,
                desc = "Git branches"
            },
        }
    },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        config = function()
            require("telescope").load_extension("fzf")
        end
    },
    {
        "olacin/telescope-cc.nvim",
        config = function()
            require("telescope").load_extension("conventional_commits")
        end,
        keys = {
            {
                "<leader>gc",
                create_conventional_commit,
                desc = "Conventional Commits"
            },
        }
    },
    {
        "nvim-telescope/telescope-file-browser.nvim",
        config = function()
            require("telescope").load_extension("file_browser")
        end,
    },
    {
        "renerocksai/telekasten.nvim",
        dependencies = { "nvim-telescope/telescope.nvim" },
        config = {
            home = vim.fn.expand("~/zettelkasten")
        }
    },
}
