vim.pack.add({ { src = "https://github.com/stevearc/conform.nvim.git", version = "master" } })

require("conform").setup({
	format_on_save = {
		lsp_format = "fallback",
	},
	formatters_by_ft = {
		lua = { "stylua", lsp_format = "fallback" },
		cpp = { "clangd", lsp_format = "prefer" },
		cmake = { "cmakelang" },
	},
})
