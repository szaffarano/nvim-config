vim.pack.add {
  { src = 'https://github.com/folke/trouble.nvim' },
}

require('trouble').setup {}

local map = vim.keymap.set
map('n', '<leader>tx', '<cmd>Trouble diagnostics toggle<cr>', { desc = '[T]rouble Diagnostics' })
map('n', '<leader>tX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', { desc = '[T]rouble Buffer Diagnostics' })
map('n', '<leader>ts', '<cmd>Trouble symbols toggle focus=false<cr>', { desc = '[T]rouble [S]ymbols' })
map(
  'n',
  '<leader>tl',
  '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
  { desc = '[T]rouble [L]SP references' }
)
map('n', '<leader>tL', '<cmd>Trouble loclist toggle<cr>', { desc = '[T]rouble [L]ocation List' })
map('n', '<leader>tQ', '<cmd>Trouble qflist toggle<cr>', { desc = '[T]rouble [Q]uickfix List' })
