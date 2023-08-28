local builtin = require('telescope.builtin')

vim.keymap.set("n", "<leader>gf", builtin.git_files)
vim.keymap.set("n", "<leader>ff", builtin.find_files)
vim.keymap.set("n", "<C-p>", builtin.find_files)
vim.keymap.set("n", "<leader>b", builtin.buffers)
vim.keymap.set("n", "<leader>fh", builtin.resume)
vim.keymap.set("n", "<leader>lg", builtin.live_grep)
vim.keymap.set("n", "<leader>fg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")
vim.keymap.set("n", "<leader>fs", ":lua require 'telescope'.extensions.file_browser.file_browser( { path = vim.fn.expand('%:p:h') } )<CR>")
vim.keymap.set("n", "<leader>gb", ":Telescope git_branches<cr>")
vim.keymap.set("n", "<leader>rr", ":Telescope lsp_references<cr>")
vim.keymap.set("n", "<leader>df", ":Telescope diagnostics<cr>")
vim.keymap.set("n", "<leader>q", require('telescope.builtin').quickfix)

local fb_actions = require "telescope._extensions.file_browser.actions"
local lga_actions = require("telescope-live-grep-args.actions")

local ts_select_dir_for_grep = function(prompt_bufnr)
  local action_state = require("telescope.actions.state")
  local fb = require("telescope").extensions.file_browser
  local live_grep = require("telescope.builtin").live_grep
  local current_line = action_state.get_current_line()

  fb.file_browser({
    files = false,
    depth = false,
    attach_mappings = function(prompt_bufnr)
      require("telescope.actions").select_default:replace(function()
        local entry_path = action_state.get_selected_entry().Path
        local dir = entry_path:is_dir() and entry_path or entry_path:parent()
        local relative = dir:make_relative(vim.fn.getcwd())
        local absolute = dir:absolute()

        live_grep({
          results_title = relative .. "/",
          cwd = absolute,
          default_text = current_line,
        })
      end)

      return true
    end,
  })
end

require('telescope').setup {
  pickers = {
    live_grep = {
      mappings = {
        i = {
          ["<C-f>"] = ts_select_dir_for_grep,
        },
        n = {
          ["<C-f>"] = ts_select_dir_for_grep,
        },
      },
    },
    buffers = {
      mappings = {
        n = {
          ['<C-d>'] = require('telescope.actions').delete_buffer
        }
      }
    }
  },
  extensions = {
    project = {
      base_dirs = {
        '~/dev',
      },
      hidden_files = true,
      theme = "dropdown"
    },
    file_browser = {
      mappings = {
        i = {
          ["<C-r>"] = fb_actions.rename
        },
      }
    },
    live_grep_args = {
      auto_quoting = true,
      mappings = {
        i = {
          ["<C-k>"] = lga_actions.quote_prompt(),
          ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
        },
      },
    },
  }
}

-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')

-- Reloading Neovim Config With Telescope
-- https://ustrajunior.com/posts/reloading-neovim-config-with-telescope/
P = function(v)
  print(vim.inspect(v))
  return v
end

if pcall(require, "plenary") then
  RELOAD = require("plenary.reload").reload_module

  R = function(name)
    RELOAD(name)
    return require(name)
  end
end

-- Reload lua when config changes
local function reload()
  -- Telescope will give us something like user/colors.lua,
  -- so this function convert the selected entry to
  -- the module name: user.colors
  local function get_module_name(s)
    local module_name;

    module_name = s:gsub("%.lua", "")
    module_name = module_name:gsub("%/", ".")
    module_name = module_name:gsub("%.init", "")

    return module_name
  end

  local prompt_title = "~ NVIM config ~"

  -- sets the path to the lua folder
  local path = "~/.config/nvim/lua"

  local opts = {
    prompt_title = prompt_title,
    cwd = path,

    attach_mappings = function(_, map)
     -- Adds a new map to ctrl+e.
      map("i", "<c-e>", function(_)
        -- these two a very self-explanatory
        local entry = require("telescope.actions.state").get_selected_entry()
        local name = get_module_name(entry.value)

        -- call the helper method to reload the module
        -- and give some feedback
        R(name)
        P(name .. " reloaded")
      end)

      return true
    end
  }

  -- call the builtin method to list files
  require('telescope.builtin').find_files(opts)
end

vim.keymap.set("n", "<Leader>qr", reload)
