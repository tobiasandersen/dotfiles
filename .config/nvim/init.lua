if vim.g.vscode then
  vim.cmd('source ~/.config/nvim/vscode.vim')
else
  require "user.options"
  require "user.plugins"
  require "user.keymap"
  require "user.colorscheme"
  require "user.telescope"
  require "user.treesitter"
  require "user.mason"
  require "user.nvim-tree"
  require "user.null-ls"
  require "user.autopairs"
  -- require "user.toggleterm"
  require "user.lualine"
  require "user.comments"
  require "user.cmp"
  require "user.lsp"
end
