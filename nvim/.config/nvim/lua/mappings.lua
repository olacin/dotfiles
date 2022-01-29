local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

vim.g.mapleader = " "

map("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>")
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>")

map("n", "<leader>Y", "gg\"+yG")

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

-- escape insert mode quicker
map("i", "jk", "<esc>")

-- open gitmoji to commit
map("n", "<leader>c", "<cmd>Telescope gitmoji search<cr>")
