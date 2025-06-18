return {
	"lervag/vimtex",
	lazy = false, -- we don't want to lazy load VimTeX
	-- tag = "v2.15", -- uncomment to pin to a specific release
	config = function()
		vim.g.vimtex_compiler_latexmk = {
			backend = "nvim",
			build_dir = "",
			callback = 1,
			continuous = 1,
			executable = "latexmk",
			options = {
				"-lualatex",
				"-file-line-error",
				"-synctex=1",
				"-interaction=nonstopmode",
			},
		}
	end,
}
