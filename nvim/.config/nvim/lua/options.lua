local o = vim.opt
local wo = vim.wo
local cmd = vim.cmd

o.number = true
o.relativenumber = true
o.autoindent = true
o.tabstop = 4
o.shiftwidth = 4
o.showmode = false
o.completeopt = { "menu", "menuone", "noselect" }
o.termguicolors = true
vim.o.background = "dark"

cmd("colorscheme gruvbox")
wo.colorcolumn = "88"
