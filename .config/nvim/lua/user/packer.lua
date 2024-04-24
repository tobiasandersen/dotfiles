local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

-- Install your plugins here
return require('packer').startup(function(use)
  -- Packer can manage itself
  use "wbthomason/packer.nvim"

  -- Telescope
  use {"nvim-telescope/telescope.nvim", requires = {'nvim-lua/plenary.nvim'}}
  use "BurntSushi/ripgrep" -- required for live_grep and grep_string and is the first priority for find_files.
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' } -- native telescope sorter to improve sorting performance
  use "nvim-telescope/telescope-live-grep-args.nvim"
  use "nvim-telescope/telescope-file-browser.nvim"

  -- LSP
  use "neovim/nvim-lspconfig"
  use "williamboman/mason.nvim"
  use "williamboman/mason-lspconfig.nvim"
  use "jose-elias-alvarez/null-ls.nvim"

  -- Completion
  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-cmdline"
  use {'tzachar/fuzzy.nvim', requires = {'nvim-telescope/telescope-fzf-native.nvim'}}
  use "github/copilot.vim"
  -- use "~/dev/oss/cmp-fuzzy-path"
  -- use {"tzachar/cmp-fuzzy-path", requires = {"hrsh7th/nvim-cmp", "tzachar/fuzzy.nvim"}}

  -- Treesitter
  use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })
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
  use "nvim-treesitter/nvim-treesitter-context"

  -- Color Schemes
  use "folke/tokyonight.nvim"
  use { "catppuccin/nvim", as = "catppuccin" }

  -- Statusline
  use 'tjdevries/express_line.nvim'

  -- File Explorer
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons',
    }
  }

  use "tpope/vim-surround"
  use "tpope/vim-repeat"
  use "tpope/vim-fugitive"
  use "ThePrimeagen/harpoon"
  use "mbbill/undotree"

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
