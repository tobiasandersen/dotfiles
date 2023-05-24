local lsp = vim.lsp
local fn = vim.fn
local diagnostic = vim.diagnostic

local function config(_config)
	return vim.tbl_deep_extend("force", {
		on_attach = function(client)
      -- Disable document formatting since we're using null_ls for this.
      client.server_capabilities.document_formatting = false

      -- Set up key bindings
			vim.keymap.set("n", "gd", function() lsp.buf.definition() end)
			vim.keymap.set("n", "K", function() lsp.buf.hover() end)
			vim.keymap.set("n", "<leader>vws", function() lsp.buf.workspace_symbol() end)
			vim.keymap.set("n", "<leader>vd", function() diagnostic.open_float() end)
			vim.keymap.set("n", "[d", function() diagnostic.goto_next() end)
			vim.keymap.set("n", "]d", function() diagnostic.goto_prev() end)
			vim.keymap.set("n", "<leader>vca", function() lsp.buf.code_action() end)
			vim.keymap.set("n", "<leader>vco", function() lsp.buf.code_action({
                filter = function(code_action)
                    if not code_action or not code_action.data then
                        return false
                    end

                    local data = code_action.data.id
                    return string.sub(data, #data - 1, #data) == ":0"
                end,
                apply = true
            }) end)
			vim.keymap.set("n", "<leader>vrr", function() lsp.buf.references() end)
			vim.keymap.set("n", "<leader>vrn", function() lsp.buf.rename() end)
			vim.keymap.set("i", "<C-h>", function() lsp.buf.signature_help() end)
		end,
	}, _config or {})
end

require("lspconfig").tsserver.setup(config())

require("lspconfig").cssls.setup(config())

require("lspconfig").eslint.setup({
  enable = true,
  lintTask = {
    enable = true,
  },
  root_dir = require("lspconfig").util.root_pattern('.eslintrc.json', '.eslintrc.js', 'package.json', 'tsconfig.json', '.git')
})

-- Change diagnostic signs.
fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError" })
fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" })
fn.sign_define("DiagnosticSignInformation", { text = "󰙎", texthl = "DiagnosticSignInfo" })
fn.sign_define("DiagnosticSignHint", { text = "󰌶", texthl = "DiagnosticSignHint" })

-- Global config for diagnostic.
diagnostic.config({
  underline = {
    severity = { min = vim.diagnostic.severity.ERROR }
  },
  virtual_text = false,
  sign = true,
  -- {
  --   severity = { min = vim.diagnostic.severity.WARN }
  -- },
  severity_sort = true
  --   severity = { min = vim.diagnostic.severity.WARN }
  -- },
})

-- Open diagnostic float on cursor hold.
-- vim.api.nvim_create_autocmd(
--   "CursorHold",
--   { command = "lua vim.diagnostic.open_float()" }
-- )
