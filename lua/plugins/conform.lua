return {
	"stevearc/conform.nvim",
	dependencies = {
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	opts = {},
	config = function()
		local formatters_by_ft = {
			lua = { "stylua" },
			-- You can customize some of the format options for the filetype (:help conform.format)
			rust = { "rustfmt", lsp_format = "fallback" },
			python = { "black", lsp_format = "fallback" },
			-- Conform will run the first available formatter
			javascript = { "prettier", stop_after_first = true },
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
			},
		})
	end,
}
