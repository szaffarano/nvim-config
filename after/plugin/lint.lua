vim.pack.add {
  { src = 'https://github.com/mfussenegger/nvim-lint' },
}

local lint = require 'lint'

lint.linters_by_ft = {
  bash = { 'bash' },
  dockerfile = { 'hadolint' },
  fish = { 'fish' },
  go = { 'golangcilint' },
  markdown = { 'rumdl' },
  nix = { 'nix' },
  sh = { 'shellcheck' },
  zsh = { 'zsh' },
}

local lint_group = vim.api.nvim_create_augroup('my.lint', { clear = true })

vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
  group = lint_group,
  callback = function()
    lint.try_lint()
  end,
})

-- Skip linting for secret files
vim.api.nvim_create_autocmd('BufEnter', {
  group = lint_group,
  pattern = { '.env', '.envrc' },
  callback = function(event)
    vim.diagnostic.enable(false, { bufnr = event.buf })
  end,
})
