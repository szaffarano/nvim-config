vim.pack.add {
  { src = 'https://github.com/folke/which-key.nvim' },
}

local wk = require 'which-key'

wk.setup {
  delay = vim.o.timeoutlen,
  icons = { mappings = true },
}

-- Register key group prefixes so which-key shows group names
wk.add {
  { '<leader>s', group = 'Search' },
  { '<leader>l', group = 'LSP' },
  { '<leader>o', group = 'Org' },
  { '<leader>n', group = 'Roam' },
  { '<leader>r', group = 'Rust' },
  { '<leader>f', group = 'File' },
}
