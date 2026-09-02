vim.pack.add({ "https://github.com/vague-theme/vague.nvim" })
vim.cmd.colorscheme("vague")

local groups = {
	"Normal",
	"NormalNC",
	"SignColumn",
	"NormalFloat",
	"EndOfBuffer",
}

for _, group in ipairs(groups) do
	vim.api.nvim_set_hl(0, group, { bg = "none" })
end
