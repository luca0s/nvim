return {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
        vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
    config = function ()
        vim.keymap.set("n", "<leader>mdn", ":MarkdownPreview<CR>")
        vim.keymap.set("n", "<leader>mds", ":MarkdownPreviewStop<CR>")
    end
}
