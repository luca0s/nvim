vim.pack.add({{src = "https://github.com/nvim-tree/nvim-tree.lua.git", version = "master"}})
require("nvim-tree").setup({
	view = {
		width = 40,
		side = "right"
	},
})
