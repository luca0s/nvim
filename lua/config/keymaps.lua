vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = 'Move selected lines down' })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = 'Move selected lines up' })

vim.keymap.set("n", "n", "nzzzv", { desc = 'Keeps cursor centered when serching' })
vim.keymap.set("n", "N", "Nzzzv", { desc = 'Keeps cursor centered when serching' })

-- Copies to system clipboard
vim.keymap.set({ "n", "v" }, "y", [["+y]], { desc = "Copy to system clipboard" })
vim.keymap.set("n", "Y", [["+Y]], { desc = "Copy to system clipboard" })

-- Pastes from system clipboard
vim.keymap.set({ "n", "v" }, "p", [["+p]], { desc = "Paste from system clipboard" })
vim.keymap.set("n", "P", [["+P]], { desc = "Paste from system clipboard" })

-- Cuts to system clipboard in visual modes and discards in normal mode
vim.keymap.set("n", "x", [["_x]], { desc = "Discard cuts in normal mode" })
vim.keymap.set("n", "X", [["_X]], { desc = "Discard cuts in normal mode" })
vim.keymap.set("v", "x", [["+x]], { desc = "Copy cuts to system clipboard in visual mode" })
vim.keymap.set("v", "X", [["+X]], { desc = "Copy cuts to system clipboard in visual mode" })
