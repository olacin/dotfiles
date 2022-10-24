import("dressing", function(dressing)
    dressing.setup({
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
end)
