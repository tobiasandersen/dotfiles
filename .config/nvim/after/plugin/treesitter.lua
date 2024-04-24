require("nvim-treesitter.configs").setup {
  highlight = {
    enable = true,
    disable = {},
  },
  indent = {
    enable = true,
    disable = {},
  },
  ensure_installed = {
    "tsx",
    "javascript",
    "typescript",
    "toml",
    "json",
    "yaml",
    "css",
    "html",
    "lua"
  },
  autotag = {
    enable = false,
  },
  autopairs = {
    enable = true
  },
  endwise = {
    enable = true,
  },
}

require('treesitter-context').setup {
  enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
}

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
