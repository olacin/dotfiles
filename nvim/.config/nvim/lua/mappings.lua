local function map(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

vim.g.mapleader = " "

map("n", "<leader><space>", "<cmd>Telescope buffers<cr>")
map("n", "<leader>sf", "<cmd>Telescope find_files<cr>")
map("n", "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>")
map("n", "<leader>sh", "<cmd>Telescope help_tags<cr>")
map("n", "<leader>sd", "<cmd>Telescope grep_string<cr>")
map("n", "<leader>sp", "<cmd>Telescope live_grep<cr>")

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

-- escape insert mode quicker
map("i", "jk", "<esc>")

-- open gitmoji to commit
map("n", "<leader>c", "<cmd>Telescope gitmoji search<cr>")

-- hop
-- place this in one of your configuration file(s)
map(
	"n",
	"f",
	"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>",
	{}
)
map(
	"n",
	"F",
	"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>",
	{}
)
map(
	"o",
	"f",
	"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, inclusive_jump = true })<cr>",
	{}
)
map(
	"o",
	"F",
	"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, inclusive_jump = true })<cr>",
	{}
)
map(
	"",
	"t",
	"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>",
	{}
)
map(
	"",
	"T",
	"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>",
	{}
)
