vim.pack.add({{ src = "https://github.com/jiaoshijie/undotree.git", version = "main"}})

require("undotree").setup({
    float_diff = true, -- set this `true` will disable layout option
    --- @type "left_bottom" | "left_left_bottom"
    layout = "left_bottom", -- {left}_{bottom} {left}_{left_bottom}
    --- @type "left" | "right"
    position = "left",
    window = {
        width = 0.15, -- the `undotree` window width percentage related to the editor
        height = 0.25, -- the `preview`(not floating) window height percentage related to the editor
        border = "rounded", -- float window
    },

    ignore_filetype = {},
    --- @type "compact" | "legacy"
    parser = "compact",

    keymaps = {
        ["move_next"] = "j",
        ["move_prev"] = "k",
        ["move2parent"] = "gj",
        ["move_change_next"] = "J",
        ["move_change_prev"] = "K",
        ["action_enter"] = "<cr>",
        ["enter_diffbuf"] = "p", -- is defined for both undotree and preview buffers, so it works as a toggle
        ["quit"] = "q", -- is defined for both undotree and preview buffers
        ["update_undotree_view"] = "S",
    },
})
