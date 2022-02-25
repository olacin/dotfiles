local function map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end

local function with_theme(rhs)
    local themes = require("telescope.themes")

    return function()
        return rhs(themes.get_dropdown({}))
    end
end

vim.g.mapleader = " "

-- Telescope mappings
local ok, telescope = pcall(require, "telescope")
if ok then
    local builtin = require("telescope.builtin")
    map("n", "<leader>fb", with_theme(builtin.buffers))
    map("n", "<leader>ff", with_theme(builtin.find_files))
    map("n", "<leader>ft", with_theme(builtin.git_files))
    map("n", "<leader>fg", with_theme(builtin.live_grep))
    map("n", "<leader>fh", with_theme(builtin.help_tags))
    map("n", "<leader>gw", with_theme(builtin.grep_string))
    map("n", "<leader>gb", with_theme(builtin.git_branches))
    map("n", "<leader>gc", with_theme(telescope.extensions.gitmoji.search))
end

-- Docstring
local ok, neogen = pcall(require, "neogen")
if ok then
    map("n", "<leader>d", neogen.generate)
end

-- Luasnip mappings
local ok, luasnip = pcall(require, "luasnip")
if ok then
    map({ "i", "s" }, "<C-k>", function()
        if luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
        end
    end)
    map({ "i", "s" }, "<C-j>", function()
        if luasnip.jumpable(-1) then
            luasnip.jump(-1)
        end
    end)
end

map("i", "jk", "<esc>")

-- yank file into clipboard
map("n", "<leader>Y", 'gg"+yG')

-- keep centered
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map("n", "J", "mzJ`z")

-- undo breakpoints
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", "!", "!<c-g>u")
map("i", "?", "?<c-g>u")
map("i", ";", ";<c-g>u")
map("i", ":", ":<c-g>u")

-- move text
map("v", "J", ":m '>+1<CR>==gv=gv")
map("v", "K", ":m '<-2<CR>==gv=gv")
map("n", "<leader>j", "<cmd>m .+1<CR>==")
map("n", "<leader>k", "<cmd>m .-2<CR>==")
