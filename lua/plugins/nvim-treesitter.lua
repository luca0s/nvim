vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		if ev.data.spec.name == "nvim-treesitter" and (ev.data.kind == "install" or ev.data.kind == "update") then
			if not ev.data.active then
				vim.cmd.packadd("nvim-treesitter")
			end

			vim.cmd.TSUpdate()
		end
	end,
})

vim.pack.add({ {
	src = "https://github.com/nvim-treesitter/nvim-treesitter",
	version = "main",
} })

require("nvim-treesitter").install({ "lua", "rust", "cpp" })
