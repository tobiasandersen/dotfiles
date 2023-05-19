local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
  return
end

toggleterm.setup {
  size = 20,
  open_mapping = [[<C-\>]],
  hide_numbers = true,
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = 2,
  start_in_insert = true,
  insert_mappings = true,
  persist_size = true,
  direction = "float",
  close_on_exit = true,
  shell = vim.o.shell,
  float_opts = {
    border = "curved",
    winblend = 0,
    highlights = {
      border = "Normal",
      background = "Normal",
    },
  },
}

function _G.set_terminal_keymaps()
  local opts = { noremap = true }
  vim.api.nvim_buf_set_keymap(0, "t", "<c-h>", [[<C-\><C-n><C-W>h]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<c-j>", [[<C-\><C-n><C-W>j]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<c-k>", [[<C-\><C-n><C-W>k]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<c-l>", [[<C-\><C-n><C-W>l]], opts)
end

vim.cmd "autocmd! TermOpen term://* lua set_terminal_keymaps()"

local Terminal = require("toggleterm.terminal").Terminal

-- Floating Term

local floating_term = Terminal:new {
  direction = "float",
  on_open = function(term)
    vim.cmd "startinsert!"
    vim.api.nvim_buf_set_keymap(
      term.bufnr,
      "n",
      "<C-n>",
      "<cmd>1ToggleTerm<CR>",
      { noremap = true, silent = true }
    )
    vim.api.nvim_buf_set_keymap(
      term.bufnr,
      "t",
      "<C-n>",
      "<cmd>1ToggleTerm<CR>",
      { noremap = true, silent = true }
    )
    vim.api.nvim_buf_set_keymap(
      term.bufnr,
      "i",
      "<C-n>",
      "<cmd>1ToggleTerm<CR>",
      { noremap = true, silent = true }
    )
  end,
  count = 1
}

function _FLOATING_TERM()
  floating_term:toggle()
end

vim.api.nvim_set_keymap("n", "<C-n>", "<cmd>lua _FLOATING_TERM()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-n>", "<cmd>lua _FLOATING_TERM()<CR>", { noremap = true, silent = true })

-- Vertical Term

local vertical_term = Terminal:new {
  direction = "vertical",
  on_open = function(term)
    vim.cmd "startinsert!"
    vim.api.nvim_buf_set_keymap(
      term.bufnr,
      "n",
      "<Leader>ll",
      "<cmd>2ToggleTerm<CR>",
      { noremap = true, silent = true }
    )
    vim.api.nvim_buf_set_keymap(
      term.bufnr,
      "t",
      "<Leader>ll",
      "<cmd>2ToggleTerm<CR>",
      { noremap = true, silent = true }
    )
    vim.api.nvim_buf_set_keymap(
      term.bufnr,
      "i",
      "<Leader>ll",
      "<cmd>2ToggleTerm<CR>",
      { noremap = true, silent = true }
    )
  end,
  count = 2
}

function _VERTICAL_TERM()
  vertical_term:toggle(100)
end

vim.api.nvim_set_keymap("n", "<Leader>ll", "<cmd>lua _VERTICAL_TERM()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<Leader>ll", "<cmd>lua _VERTICAL_TERM()<CR>", { noremap = true, silent = true })

-- Horizontal Term

local horizontal_term = Terminal:new {
  direction = "horizontal",
  on_open = function(term)
    vim.cmd "startinsert!"
    vim.api.nvim_buf_set_keymap(
      term.bufnr,
      "n",
      "<Leader>jj",
      "<cmd>3ToggleTerm<CR>",
      { noremap = true, silent = true }
    )
    vim.api.nvim_buf_set_keymap(
      term.bufnr,
      "t",
      "<Leader>jj",
      "<cmd>3ToggleTerm<CR>",
      { noremap = true, silent = true }
    )
    vim.api.nvim_buf_set_keymap(
      term.bufnr,
      "i",
      "<Leader>jj",
      "<cmd>3ToggleTerm<CR>",
      { noremap = true, silent = true }
    )
  end,
  count = 3
}

function _HORIZONTAL_TERM()
  horizontal_term:toggle(40)
end

vim.api.nvim_set_keymap("n", "<Leader>jj", "<cmd>lua _HORIZONTAL_TERM()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<Leader>jj", "<cmd>lua _HORIZONTAL_TERM()<CR>", { noremap = true, silent = true })

