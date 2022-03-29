local ok, gitsigns = pcall(require, "gitsigns")
if not ok then
    return
end

gitsigns.setup({
    signcolumn = false,
    numhl = true,
    current_line_blame = false,
})
