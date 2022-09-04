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
end
