local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- https://github.com/ThePrimeagen/.dotfiles/blob/master/nvim/.config/nvim/lua/theprimeagen/keymap.lua
local M = {}

local function bind(op, outer_opts)
    outer_opts = outer_opts or {noremap = true}
    return function(lhs, rhs, opts)
        opts = vim.tbl_extend("force",
            outer_opts,
            opts or {}
        )
        vim.keymap.set(op, lhs, rhs, opts)
    end
end

M.nmap = bind("n", {noremap = false})
M.nnoremap = bind("n")
M.vnoremap = bind("v")
M.xnoremap = bind("x")
M.inoremap = bind("i")

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Harpoon
keymap("n", "<leader>a", ":lua require('harpoon.mark').add_file()<CR>", opts)
keymap("n", "<C-e>", ":lua require('harpoon.ui').toggle_quick_menu()<CR>", opts)
keymap("n", "<C-h>", ":lua require('harpoon.ui').nav_file(1)<CR>", opts)
keymap("n", "<C-j>", ":lua require('harpoon.ui').nav_file(2)<CR>", opts)
keymap("n", "<C-k>", ":lua require('harpoon.ui').nav_file(3)<CR>", opts)
keymap("n", "<C-l>", ":lua require('harpoon.ui').nav_file(4)<CR>", opts)

-- keymap("n", "<C-n>", ":lua require('harpoon.tmux').gotoTerminal(1)<CR>", opts)

-- Filetree
keymap("n", "<C-t>", ":NvimTreeToggle<CR>", opts)
keymap("n", "<Leader>t", ":NvimTreeFindFile<CR>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)

-- Don't yank the word that you just pasted over
keymap("v", "<leader>p", "\"_dP", opts)

-- Yank into system clipboard
keymap("n", "<leader>y", "\"+y", opts)
keymap("v", "<leader>y", "\"+y", opts)

-- Delete into system clipboard
keymap("n", "<leader>d", "\"_d", opts)
keymap("v", "<leader>d", "\"_d", opts)

-- Open new tmux session
keymap("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)

-- Find files using Telescope command-line sugar.
keymap("n", "<leader>ff", ":Telescope find_files<cr>", opts)
keymap("n", "<leader>fb", ":Telescope buffers<cr>", opts)
keymap("n", "<leader>fh", ":Telescope resume<cr>", opts)
keymap("n", "<leader>fg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", opts)
keymap("n", "<leader>fs", ":lua require 'telescope'.extensions.file_browser.file_browser( { path = vim.fn.expand('%:p:h') } )<CR>", opts)
keymap("n", "<leader>gb", ":Telescope git_branches<cr>", opts)
keymap("n", "<leader>rr", ":Telescope lsp_references<cr>", opts)

-- Diagnostics
keymap("n", "<leader>dd", ":Telescope diagnostics<cr>", opts)
keymap("n", "<leader>dn", ":lua vim.diagnostic.goto_next()<cr>", opts)
keymap("n", "<leader>dp", ":lua vim.diagnostic.goto_prev()<cr>", opts)

-- Reload lua when config changes
keymap("n", "<Leader>qr", ":lua require('user.telescope').reload()<CR>", opts)

return M
