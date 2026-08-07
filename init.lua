vim.g.mapleader = " "

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

--
vim.api.nvim_create_user_command("Config", function()
	vim.cmd("cd " .. vim.fn.fnameescape(vim.fn.stdpath("config")))
	vim.notify("Working directory: " .. vim.fn.getcwd())
end, {
	desc = "Change directory to the Neovim config",
})

-- optionally enable 24-bit colour
vim.opt.termguicolors = true
require("telescope")
require("options")
require("colorscheme")
require("nvimtree")
require("undo_tree")
require("lsp")
require("format")
require("completion")
require("keymaps")
