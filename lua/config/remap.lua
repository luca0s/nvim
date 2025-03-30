vim.keymap.set("n", "<leader>pv", ":Oil<CR>")

-- Moves selected lines up/down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Keeps cursor in same place after doing J
vim.keymap.set("n", "J", "mzJ`z")

-- Keeps cursor in same place when doing half page jumps
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Keeps cursor in center when going trough search terms
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Copies to system clipboard
vim.keymap.set({"n", "v"}, "y", [["+y]])
vim.keymap.set("n", "Y", [["+Y]])

-- Pastes from system clipboard
vim.keymap.set({"n", "v"}, "p", [["+p]])
vim.keymap.set("n", "P", [["+P]])

-- Pastes from system clipboard
vim.keymap.set({"n", "v"}, "x", [["+x]])
vim.keymap.set("n", "X", [["+X]])

-- Replace current word
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Move between windows
vim.keymap.set("n", "<C-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<C-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<C-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<C-l>", ":wincmd l<CR>")

-- Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

