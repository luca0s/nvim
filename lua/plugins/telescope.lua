return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	config = function()
		require("telescope").setup({})

		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>ff", function()
			local success, _ = pcall(builtin.git_files)
			if not success then
				builtin.find_files()
			end
		end, {})
		vim.keymap.set("n", "<leader>fs", builtin.live_grep, {})
		vim.keymap.set("n", "<leader>fm", builtin.marks, {})
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
		vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
	end,
}
