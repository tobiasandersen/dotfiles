-- null-ls
local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    -- null_ls.builtins.diagnostics.eslint_d,
    null_ls.builtins.diagnostics.eslint,
    null_ls.builtins.formatting.prettier.with({
      filetypes = {
        "javascript","javascriptreact","typescript","typescriptreact","css","scss","html","json","yaml","markdown","graphql","md","txt",
      },
    }),
  },
  on_attach = function(client, bufnr)
    if client.server_capabilities.documentFormattingProvider then
      vim.cmd("nnoremap <silent><buffer> <Leader>f :lua vim.lsp.buf.format({ async = true })<CR>")

      -- format on save
      -- vim.cmd("autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting()")
    end

    if client.server_capabilities.documentRangeFormattingProvider then
      vim.cmd("xnoremap <silent><buffer> <Leader>f :lua vim.lsp.buf.range_formatting({})<CR>")
    end
  end,
})

