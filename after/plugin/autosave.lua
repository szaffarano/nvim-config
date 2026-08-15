vim.pack.add {
  { src = 'https://github.com/okuuva/auto-save.nvim' },
}

require('auto-save').setup {
  debug = false,
  write_all_buffers = true,
  debounce_delay = 500,
  noautocmd = false,
  trigger_events = {
    defer_save = { 'FocusLost', 'QuitPre', 'VimSuspend' },
    immediate_save = { 'FocusLost' },
    cancel_deferred_save = { 'InsertEnter' },
  },
}
