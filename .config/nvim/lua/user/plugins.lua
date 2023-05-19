local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]
-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- General
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
  use "tpope/vim-surround"
  use "tpope/vim-repeat"
  use "ThePrimeagen/harpoon"
  use "christoomey/vim-tmux-navigator"
  use "tpope/vim-fugitive"

  -- LSP
  use "neovim/nvim-lspconfig"
  use "williamboman/mason.nvim"
  use "williamboman/mason-lspconfig.nvim"
  use "jose-elias-alvarez/null-ls.nvim"

  -- Completion
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-cmdline"
  use {'tzachar/fuzzy.nvim', requires = {'nvim-telescope/telescope-fzf-native.nvim'}}
  use {"tzachar/cmp-fuzzy-path", requires = {"hrsh7th/nvim-cmp", "tzachar/fuzzy.nvim"}}


  -- Treesitter
  use("nvim-treesitter/nvim-treesitter", {
    run = ":TSUpdate"
  })
  use "RRethy/nvim-treesitter-endwise"
  use "windwp/nvim-ts-autotag"
  use "windwp/nvim-autopairs"
  use {
      'numToStr/Comment.nvim',
      config = function()
          require('Comment').setup()
      end
  }
  use "JoosepAlviste/nvim-ts-context-commentstring"

  -- Telescope
  use "nvim-telescope/telescope.nvim"
  use "BurntSushi/ripgrep" -- required for live_grep and grep_string and is the first priority for find_files.
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' } -- native telescope sorter to improve sorting performance
  use "nvim-telescope/telescope-file-browser.nvim"
  use "nvim-telescope/telescope-live-grep-args.nvim"

  -- Color Schemes
  use "folke/tokyonight.nvim"
  use "projekt0n/github-nvim-theme"
  use { "catppuccin/nvim", as = "catppuccin" }

  -- Statusline
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  -- Terminal
  use "akinsho/toggleterm.nvim"
  
  -- File Explorer
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons',
    }
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
