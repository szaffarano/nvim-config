local api = vim.api

-- Highlight yanked text briefly
api.nvim_create_autocmd('TextYankPost', {
  group = api.nvim_create_augroup('my.hl-yank', { clear = true }),
  desc = 'Highlight yanked text',
  callback = function()
    vim.hl.on_yank { higroup = 'Visual', timeout = 100 }
  end,
})

-- Restore cursor to last known position when reopening a file
-- See :h last-position-jump
api.nvim_create_autocmd('BufReadPost', {
  group = api.nvim_create_augroup('my.restore-cursor', { clear = true }),
  desc = 'Restore cursor position',
  callback = function(event)
    local mark = api.nvim_buf_get_mark(event.buf, '"')
    local line_count = api.nvim_buf_line_count(event.buf)
    if mark[1] > 0 and mark[1] <= line_count then
      pcall(api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Enable spell for prose filetypes not handled by their own ftplugin
api.nvim_create_autocmd('FileType', {
  group = api.nvim_create_augroup('my.spell', { clear = true }),
  desc = 'Enable spell check for prose filetypes',
  pattern = { 'tex', 'latex' },
  callback = function()
    vim.opt_local.spell = true
  end,
})

-- Keep quickfix list in sync with current diagnostics
api.nvim_create_autocmd('DiagnosticChanged', {
  group = api.nvim_create_augroup('my.diagnostic-qf', { clear = true }),
  desc = 'Sync diagnostics to quickfix list',
  callback = function()
    vim.diagnostic.setqflist { open = false }
  end,
})
