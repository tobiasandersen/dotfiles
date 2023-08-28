-- Keep selection when indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Move text up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Don't copy the word that you just pasted over
vim.keymap.set("v", "<leader>p", "\"_dP")

-- Copy/delete into system clipboard
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")

-- Diagnostics
vim.keymap.set("n", "<leader>dd", ":lua vim.diagnostic.open_float()<cr>")
vim.keymap.set("n", "<leader>dn", ":lua vim.diagnostic.goto_next()<cr>")
vim.keymap.set("n", "<leader>dp", ":lua vim.diagnostic.goto_prev()<cr>")

-- Better window navigation
-- vim.keymap.set("n", "<C-h>", "<C-w>h")
-- vim.keymap.set("n", "<C-j>", "<C-w>j")
-- vim.keymap.set("n", "<C-k>", "<C-w>k")
-- vim.keymap.set("n", "<C-l>", "<C-w>l")

