require("lualine").setup({
	options = {
		icons_enabled = true,
		component_separators = "|",
		section_separators = "",
		theme = "gruvbox_dark",
	},
	sections = {
		lualine_b = { "branch" },
		lualine_c = {
			{
				"diagnostics",
				sources = { "nvim_diagnostic" },
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
})
