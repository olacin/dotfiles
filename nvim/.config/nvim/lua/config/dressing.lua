local ok, dressing = pcall(require, "dressing")
if not ok then
    return
end

require("dressing").setup({
    input = {
        enabled = true,

        border = "rounded",
        relative = "editor",

        prefer_width = 50,
        width = nil,

        max_width = { 140, 0.9 },
        min_width = { 20, 0.2 },
    },
})
