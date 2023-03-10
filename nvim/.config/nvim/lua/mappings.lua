local function map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
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

local ok, harpoon = pcall(require, "harpoon.mark")
if ok then
    map("n", "<leader>h", harpoon.add_file)
end

map("n", "<leader>pv", vim.cmd.Ex)

map("i", "jk", "<esc>")

-- Git
map("n", "<leader>gp", "<Cmd>Git push<CR>")

-- yank file into clipboard
-- map("n", "<leader>Y", 'gg"+yG')
map({ "n", "v" }, "<leader>y", [["+y]])
map("n", "<leader>Y", [["+Y]])

-- keep centered
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map("n", "J", "mzJ`z")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

map("x", "<leader>p", [["_dP]])
map({ "n", "v" }, "<leader>t", [["_d]])
map("n", "<leader>m", vim.lsp.buf.format)

-- undo breakpoints
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", "!", "!<c-g>u")
map("i", "?", "?<c-g>u")
map("i", ";", ";<c-g>u")
map("i", ":", ":<c-g>u")

-- move text
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- TODO: convert these mappings in Lua
vim.cmd("nnoremap <leader>j :m .+1<CR>==")
vim.cmd("nnoremap <leader>k :m .-2<CR>==")
