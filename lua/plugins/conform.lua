return {
	"stevearc/conform.nvim",
	dependencies = {
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	opts = {},
	config = function()
		local formatters_by_ft = {
			lua = { lsp_format = "fallback" },
			python = { "black", lsp_format = "fallback" },
			javascript = { "prettier", lsp_format = "fallback" },
			typst = { "typstfmt", lsp_format = "fallback" },
		}

		local ensure_installed = {}
		for _, name in pairs(formatters_by_ft) do
			table.insert(ensure_installed, name[1])
		end

		require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
		require("conform").setup({
			formatters_by_ft = formatters_by_ft,
			format_on_save = {
				timeout_ms = 500,
				lsp_format = "fallback",
				async = false,
			},
		})
	end,
}
