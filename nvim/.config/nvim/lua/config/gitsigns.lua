local ok, gitsigns = pcall(require, "gitsigns")
if not ok then
    return
end

gitsigns.setup({
    signcolumn = false,
    numhl = true,
    current_line_blame = true,
    current_line_blame_opts = {
        virt_text_pos = "right_align", -- 'eol' | 'overlay' | 'right_align'
    },
})
