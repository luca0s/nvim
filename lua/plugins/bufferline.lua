vim.pack.add({ { src = "https://github.com/akinsho/bufferline.nvim.git", version = "main" } })

require("bufferline").setup({
	highlights = {
		buffer_selected = {
			fg = "#ffffff",
			bold = true,
			italic = true,
		},
	},
})
