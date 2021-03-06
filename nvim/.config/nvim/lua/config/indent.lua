local ok, indent = pcall(require, "indent_blankline")
if not ok then
    return
end

indent.setup({
    buftype_exclude = { "terminal", "telescope", "nofile" },
    filetype_exclude = { "help", "dashboard", "packer", "Trouble", "TelescopePrompt", "Float" },
    show_current_context = true,
    show_current_context_start = false,
    space_char_blankline = " ",
    use_treesitter = true,
})
