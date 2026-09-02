vim.g.mapleader = " "

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true

vim.api.nvim_create_user_command("Config", function()
	vim.cmd("cd " .. vim.fn.fnameescape(vim.fn.stdpath("config")))
	vim.notify("Working directory: " .. vim.fn.getcwd())
end, {
	desc = "Change directory to the Neovim config",
})

require("config.options")
require("config.colorscheme")
require("config.statusline")
require("config.terminal")

require("plugins.telescope")
require("plugins.nvimtree")
require("plugins.undotree")
require("plugins.lsp")
require("plugins.format")
require("plugins.completion")
require("plugins.bufferline")
require("plugins.nvim-treesitter")

require("config.keymaps")
