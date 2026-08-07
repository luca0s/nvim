vim.pack.add({
	{ src = "https://github.com/rafamadriz/friendly-snippets.git", version = "main" },
	{ src = "https://github.com/saghen/blink.cmp.git", version = "v1" },
})

require("blink.cmp").setup({
	keymap = { preset = "super-tab" },
	fuzzy = { implementation = "prefer_rust_with_warning" },
	completion = { documentation = { auto_show = true } },
	signature = { enabled = true },
})
