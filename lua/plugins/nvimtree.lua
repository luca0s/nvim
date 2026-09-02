vim.pack.add({ { src = "https://github.com/nvim-tree/nvim-tree.lua.git", version = "master" } })

local api = require("nvim-tree.api")
require("nvim-tree").setup({
	view = {
		width = 40,
		side = "right",
	},
	on_attach = function(bufnr)
		local opts = { buffer = bufnr, noremap = true, silent = true }

		vim.keymap.set("n", "h", api.tree.change_root_to_parent, opts)
		vim.keymap.set("n", "l", api.tree.change_root_to_node, opts)
		vim.keymap.set("n", "d", api.fs.remove, opts)
		vim.keymap.set("n", "r", api.fs.rename, opts)
		vim.keymap.set("n", "c", api.fs.create, opts)
		vim.keymap.set("n", "c", api.fs.create, opts)
		vim.keymap.set("n", "<CR>", api.node.open.edit, opts)
	end,
})
