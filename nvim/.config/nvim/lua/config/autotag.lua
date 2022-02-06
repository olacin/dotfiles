local ok, treesitter_configs = pcall(require, "nvim-treesitter.configs")
if not ok then
	return
end

treesitter_configs.setup({
	autotag = {
		enable = true,
	},
})
