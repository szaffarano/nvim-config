vim.pack.add {
  'https://github.com/stevearc/oil.nvim',
}

require('oil').setup {
  default_file_explorer = true,
  skip_confirm_for_simple_edits = true,
  view_options = {
    show_hidden = true,
    natural_order = false,
  },
}

vim.keymap.set('n', '-', '<cmd>Oil<cr>', { desc = 'Open parent directory' })
