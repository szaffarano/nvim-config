vim.pack.add {
  { src = 'https://github.com/nvim-mini/mini.nvim' },
  { src = 'https://github.com/nvim-mini/mini.extra' },
  { src = 'https://github.com/rafamadriz/friendly-snippets' },
}

local pick = require 'mini.pick'
local extra = require 'mini.extra'
local ai = require 'mini.ai'
local snippets = require 'mini.snippets'
local statusline = require 'mini.statusline'
local surround = require 'mini.surround'
local diff = require 'mini.diff'
local pairs = require 'mini.pairs'

pick.setup {
  mappings = {
    toggle_info = '<C-k>',
    choose = '<C-y>',
  },
}

pick.registry.modified = function()
  return pick.builtin.cli(
    { command = { 'git', 'diff', '--name-only', 'HEAD' } },
    { source = { name = 'Modified files' } }
  )
end

pick.registry.config = function()
  return pick.builtin.files(nil, { source = { cwd = vim.fn.stdpath 'config' } })
end

ai.setup {
  n_lines = 500,
  custom_textobjects = {
    -- Function
    f = ai.gen_spec.treesitter { a = '@function.outer', i = '@function.inner' },
    -- Class
    c = ai.gen_spec.treesitter { a = '@class.outer', i = '@class.inner' },
  },
}

snippets.setup {
  snippets = {
    snippets.gen_loader.from_lang(),
  },
}

surround.setup {
  mappings = {
    add = 'Sa',
    delete = 'Sd',
    find = 'Sf',
    find_left = 'SF',
    highlight = 'Sh',
    replace = 'Sr',
    update_n_lines = 'Sn',
  },
}

diff.setup {
  source = diff.gen_source.none(),
}

pairs.setup()

statusline.setup { use_icons = true }

local keymap = vim.keymap
local ep = extra.pickers

keymap.set('n', '<leader>sf', '<cmd>Pick files<cr>', { desc = 'Find files' })
keymap.set('n', '<leader>sg', '<cmd>Pick grep_live<cr>', { desc = 'Live grep' })
keymap.set('n', '<leader><leader>', '<cmd>Pick buffers<cr>', { desc = 'Find buffers' })
keymap.set('n', '<leader>sh', '<cmd>Pick help<cr>', { desc = 'Find help' })
keymap.set('n', '<leader>sm', '<cmd>Pick modified<cr>', { desc = 'Find git-modified files' })
keymap.set('n', '<leader>sc', '<cmd>Pick config<cr>', { desc = 'Find config files' })
keymap.set('n', '<leader>sd', ep.diagnostic, { desc = 'Find diagnostics' })
keymap.set('n', '<leader>sr', function()
  ep.lsp { scope = 'references' }
end, { desc = 'Find LSP references' })

keymap.set('n', 'gd', function()
  ep.lsp { scope = 'definition' }
end, { desc = 'Go to definition' })
keymap.set('n', 'gr', function()
  ep.lsp { scope = 'references' }
end, { desc = 'Go to references' })
keymap.set('n', 'gI', function()
  ep.lsp { scope = 'implementation' }
end, { desc = 'Go to implementation' })
