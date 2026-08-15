vim.api.nvim_create_autocmd('BufWritePre', {
  buffer = vim.api.nvim_get_current_buf(),
  group = vim.api.nvim_create_augroup('my.zig-save-actions-' .. vim.api.nvim_get_current_buf(), { clear = true }),
  callback = function()
    vim.lsp.buf.code_action {
      context = { only = { 'source.fixAll', 'source.organizeImports' } },
      apply = true,
    }
  end,
})
