return {
    "tpope/vim-dispatch",
    config = function ()
        vim.keymap.set("n", "<leader>b", ":w<CR>:Dispatch<CR>");
        vim.g.zig_fmt_parse_errors = 0

        vim.api.nvim_create_autocmd("FileType", {
            pattern = "zig",
            callback = function ()
                vim.b.dispatch = "zig build run"
            end,
        })
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "rs",
            callback = function ()
                vim.b.dispatch = "cargo run"
            end,
        })
    end
}
