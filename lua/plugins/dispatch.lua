return {
    "tpope/vim-dispatch",
    config = function ()
        vim.keymap.set("n", "<leader>b", ":w<CR>:Make<CR>");
        vim.g.zig_fmt_parse_errors = 0
    end
}
