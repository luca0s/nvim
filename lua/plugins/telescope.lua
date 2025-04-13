return {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    config = function()
        require("telescope").setup({})

        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
        vim.keymap.set("n", "<leader>fp", builtin.git_files, {})
        vim.keymap.set("n", "<leader>fs", builtin.live_grep, {})
        vim.keymap.set("n", "<leader>fm", builtin.marks, {})
        vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
    end
}
