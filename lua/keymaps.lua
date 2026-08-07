local function map(lhs, rhs, cmd, opts)
	local def_opts = { silent = true, noremap = true }
	local final_opts = vim.tbl_extend("force", def_opts, opts or {})
	vim.keymap.set(lhs, rhs, cmd, final_opts)
end

map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected lines up" })

map("n", "n", "nzzzv", { desc = "Keeps cursor centered when serching" })
map("n", "N", "Nzzzv", { desc = "Keeps cursor centered when serching" })

-- Copies to system clipboard
map({ "n", "v" }, "y", [["+y]], { desc = "Copy to system clipboard" })
map("n", "Y", [["+Y]], { desc = "Copy to system clipboard" })

-- Pastes from system clipboard
map({ "n", "v" }, "p", [["+p]], { desc = "Paste from system clipboard" })
map("n", "P", [["+P]], { desc = "Paste from system clipboard" })

-- Cuts to system clipboard in visual modes and discards in normal mode
map("n", "x", [["_x]], { desc = "Discard cuts in normal mode" })
map("n", "X", [["_X]], { desc = "Discard cuts in normal mode" })
map("v", "x", [["+x]], { desc = "Copy cuts to system clipboard in visual mode" })
map("v", "X", [["+X]], { desc = "Copy cuts to system clipboard in visual mode" })

map("n", "<C-h>", "<C-w><C-h>")
map("n", "<C-j>", "<C-w><C-j>")
map("n", "<C-k>", "<C-w><C-k>")
map("n", "<C-l>", "<C-w><C-l>")

-- Undotree
map("n", "<leader>u", function()
	require("undotree").toggle()
end)

-- Nvimtree
map("n", "<leader>e", ":NvimTreeToggle<CR>")

-- Telescope
local builtin = require("telescope.builtin")
map("n", "<leader>ff", builtin.find_files)
map("n", "<leader>fg", builtin.grep_string)
map("n", "<leader>fs", builtin.lsp_document_symbols)
map("n", "<leader>fd", builtin.diagnostics)
map("n", "<leader>fp", builtin.git_files)
map("n", "<leader>fh", builtin.help_tags)

-- Terminal
local term = require("terminal")

map({ "n", "t" }, "<C-t>", term.toggle, {
	silent = true,
	desc = "Toggle bottom terminal",
})

-- Escape terminal mode without closing the terminal.
map("t", "<Esc>", [[<C-\><C-n>]], {
	silent = true,
	desc = "Leave terminal mode",
})
