local buf = vim.api.nvim_get_current_buf()
local keymap = vim.keymap

vim.opt_local.formatoptions:remove 'o'

keymap.set('n', '<leader>la', function()
  vim.cmd.RustLsp 'codeAction'
end, { buffer = buf, desc = 'Code action (Rust)' })
keymap.set('n', '<leader>rd', function()
  vim.cmd.RustLsp 'relatedDiagnostics'
end, { buffer = buf, desc = 'Related diagnostics' })
keymap.set('n', '<leader>rh', function()
  vim.cmd.RustLsp { 'hover', 'range' }
end, { buffer = buf, desc = 'Hover range' })
keymap.set('n', 'K', function()
  vim.cmd.RustLsp { 'hover', 'actions' }
end, { buffer = buf, desc = 'Hover documentation (Rust)' })
keymap.set('n', '<leader>re', function()
  vim.cmd.RustLsp { 'renderDiagnostic', 'current' }
end, { buffer = buf, desc = 'Render diagnostic' })
keymap.set('n', '<leader>rE', function()
  vim.cmd.RustLsp { 'explainError', 'current' }
end, { buffer = buf, desc = 'Explain error' })
keymap.set('n', '<leader>rod', function()
  vim.cmd.RustLsp 'openDocs'
end, { buffer = buf, desc = 'Open docs.rs' })
keymap.set('n', '<leader>rc', function()
  vim.cmd.RustLsp 'openCargo'
end, { buffer = buf, desc = 'Open Cargo.toml' })
keymap.set('n', '<leader>rj', function()
  vim.cmd.RustLsp 'joinLines'
end, { buffer = buf, desc = 'Join lines' })
