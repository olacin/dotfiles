return {
    { "stevearc/dressing.nvim",
      opts = {
        input = {
            enabled = true,
            border = "rounded",
            relative = "editor",
            prefer_width = 50,
            width = nil,
            max_width = { 140, 0.9 },
            min_width = { 20, 0.2 },
        },
      }
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "kyazdani42/nvim-web-devicons" },
        opts = {
            options = {
                icons_enabled = true,
                component_separators = "|",
                section_separators = "",
                theme = "tokyonight",
                globalstatus = true,
            },
            sections = {
                lualine_b = { "branch", "filename" },
                lualine_c = {
                    {
                        "diagnostics",
                        sources = { "nvim_diagnostic" },
                        symbols = { error = "E", warn = "W", info = "I", hint = "H" },
                    },
                },
                lualine_x = { "encoding" },
                lualine_y = { "filetype" },
                lualine_z = {
                    {
                        "fileformat",
                        symbols = {
                            unix = "LF",
                            dos = "CRLF",
                            mac = "CR",
                        },
                    },
                },
            },
        }
    },
}
