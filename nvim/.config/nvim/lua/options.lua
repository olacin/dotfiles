vim.opt.number = true
vim.opt.relativenumber = true

-- o.autoindent = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.colorcolumn = "88"
vim.opt.scrolloff = 8
vim.opt.updatetime = 50

vim.opt.showmode = false
vim.opt.winbar = "%=%m %f"
vim.opt.mouse = nil
vim.opt.completeopt = { "menu", "menuone", "noselect" }

-- cmd("colorscheme gruvbox")
vim.cmd("colorscheme tokyonight")
