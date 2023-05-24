local extensions = require "el.extensions"
local subscribe = require "el.subscribe"
local builtin = require "el.builtin"
local extensions = require "el.extensions"
local sections = require "el.sections"
local lsp_statusline = require "el.plugins.lsp_status"

local generator = function()
  return {
    extensions.mode,
    subscribe.buf_autocmd(
      "el_git_branch",
      "BufEnter",
      function(window, buffer)
        local branch = extensions.git_branch(window, buffer)
        if branch then
          return "  " .. branch
        end
      end
    ),
    sections.split,
    builtin.file_relative,
    sections.collapse_builtin {
      " ",
      builtin.modified_flag,
    },
    sections.split,
    lsp_statusline.segment,
    lsp_statusline.current_function,
    subscribe.buf_autocmd("el_git_status", "BufWritePost", function(window, buffer)
      return extensions.git_changes(window, buffer)
    end),
    "[",
    builtin.line,
    " : ",
    builtin.column,
    "]",
    sections.collapse_builtin {
      "[",
      builtin.help_list,
      builtin.readonly_list,
      "]",
    },
    " ",
    subscribe.buf_autocmd(
      "el_file_icon",
      "BufRead",
      function(_, buffer)
        return extensions.file_icon(_, buffer)
      end
    ),
  }
end

require('el').setup({ generator = generator })
