local keymap = vim.keymap
local utils = require 'config.utils'

keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlight' })

keymap.set('n', '[d', function()
  vim.diagnostic.jump { count = -1 }
end, { desc = 'Previous diagnostic' })
keymap.set('n', ']d', function()
  vim.diagnostic.jump { count = 1 }
end, { desc = 'Next diagnostic' })
keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic details' })

keymap.set('n', '<leader>q', utils.toggle_quickfix, { desc = 'Toggle quickfix list' })

keymap.set({ 'n', 'v' }, '<leader>y', '"+y', { desc = 'Yank to OS clipboard' })
keymap.set('n', '<leader>p', '"+p', { desc = 'Paste from OS clipboard' })
keymap.set({ 'n', 'v' }, '<leader>d', '"+d', { desc = 'Delete to OS clipboard' })

keymap.set('n', '<leader>cp', function()
  local path = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':.')
  vim.fn.setreg('+', path)
  vim.notify(('Copied "%s"'):format(path), vim.log.levels.INFO)
end, { desc = 'Copy relative path to clipboard' })

keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Focus left window' })
keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Focus right window' })
keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Focus lower window' })
keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Focus upper window' })

keymap.set('n', '<Left>', '<Cmd>bp<CR>', { desc = 'Previous buffer' })
keymap.set('n', '<Right>', '<Cmd>bn<CR>', { desc = 'Next buffer' })
keymap.set({ 'n', 'v' }, '<C-x>', '<Cmd>bdelete<CR>', { desc = 'Delete current buffer' })

keymap.set('n', '<C-Left>', '<Cmd>tabprev<CR>', { desc = 'Previous tab' })
keymap.set('n', '<C-Right>', '<Cmd>tabnext<CR>', { desc = 'Next tab' })

keymap.set({ 'i', 'c' }, '<C-M-h>', '<Left>', { desc = 'Move left' })
keymap.set({ 'i', 'c' }, '<C-M-l>', '<Right>', { desc = 'Move right' })
keymap.set({ 'i', 'c' }, '<C-M-j>', '<Down>', { desc = 'Move down' })
keymap.set({ 'i', 'c' }, '<C-M-k>', '<Up>', { desc = 'Move up' })

keymap.set('x', 'p', 'pgvy', { desc = 'Paste without losing register' })
