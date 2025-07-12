local opts = { silent = true, noremap = true }

-- Moves selected lines up/down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", opts)
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", opts)

-- Keeps cursor in same place after doing J
vim.keymap.set("n", "J", "mzJ`z", opts)

-- Keeps cursor in same place when doing half page jumps
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)

-- Keeps cursor in center when going trough search terms
vim.keymap.set("n", "n", "nzzzv", opts)
vim.keymap.set("n", "N", "Nzzzv", opts)

-- Copies to system clipboard
vim.keymap.set({ "n", "v" }, "y", [["+y]], opts)
vim.keymap.set("n", "Y", [["+Y]], opts)

-- Pastes from system clipboard
vim.keymap.set({ "n", "v" }, "p", [["+p]], opts)
vim.keymap.set("n", "P", [["+P]], opts)

-- Cuts to system clipboard in visual modes and discards in normal mode
vim.keymap.set("n", "x", [["_x]], opts)
vim.keymap.set("n", "X", [["_X]], opts)
vim.keymap.set("v", "x", [["+x]], opts)
vim.keymap.set("v", "X", [["+X]], opts)

-- Replace current word
-- vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Move between windows
vim.keymap.set("n", "<C-k>", ":wincmd k<CR>", opts)
vim.keymap.set("n", "<C-j>", ":wincmd j<CR>", opts)
vim.keymap.set("n", "<C-h>", ":wincmd h<CR>", opts)
vim.keymap.set("n", "<C-l>", ":wincmd l<CR>", opts)

-- Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '', opts)
vim.keymap.set('n', '<right>', '', opts)
vim.keymap.set('n', '<up>', '', opts)
vim.keymap.set('n', '<down>', '', opts)

--Correctly toggle between undotree and nvim-tree
vim.keymap.set("n", "<leader>e", function()
    vim.cmd("UndotreeHide")
    vim.cmd("NvimTreeToggle")
end, opts)
vim.keymap.set("n", "<leader>u", function()
    vim.cmd("NvimTreeClose")
    vim.cmd("UndotreeToggle")
end, opts)
