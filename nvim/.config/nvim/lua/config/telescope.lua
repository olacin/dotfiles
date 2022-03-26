local ok, telescope = pcall(require, "telescope")
if not ok then
    return
end

local actions = require("telescope.actions")
local sorters = require("telescope.sorters")
local fb_actions = telescope.extensions.file_browser.actions

telescope.setup({
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
    },
})

telescope.load_extension("fzf")
telescope.load_extension("file_browser")
telescope.load_extension("gitmoji")
telescope.load_extension("conventional_commits")
