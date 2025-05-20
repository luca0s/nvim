return {
    "sylvanfranklin/omni-preview.nvim",
    dependencies = {
        { "toppair/peek.nvim",           build = "deno task --quiet build:fast" },
        { "chomosuke/typst-preview.nvim" }
    },
    config = function()
        require("omni-preview").setup()
        require("peek").setup({ app = "browser" })
    end,
    keys = {
        { "<leader>po", "<cmd>OmniPreview start<CR>", desc = "OmniPreview Start" },
        { "<leader>pc", "<cmd>OmniPreview stop<CR>",  desc = "OmniPreview Stop" },
    }
}
