vim.pack.add {
  { src = 'https://github.com/stevearc/conform.nvim' },
}

local conform = require 'conform'

conform.setup {
  notify_on_error = false,
  formatters_by_ft = {
    asm = { 'nasmfmt' },
    bash = { 'shfmt' },
    fish = { 'fish_indent' },
    javascript = { 'prettierd', 'prettier', stop_after_first = true },
    kdl = { 'kdlfmt' },
    lua = { 'stylua' },
    markdown = { 'rumdl' },
    nix = { 'alejandra' },
    python = { 'ruff_fix', 'ruff_format', 'ruff_organize_imports' },
    rust = { 'rustfmt' },
    sh = { 'shfmt' },
    terraform = { 'terraform_fmt' },
    toml = { 'taplo' },
    typescript = { 'prettierd', 'prettier', stop_after_first = true },
    yaml = { 'yamlfmt' },
    zsh = { 'shfmt' },
  },
  format_on_save = function(bufnr)
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      return
    end
    return { timeout_ms = 500, lsp_fallback = true }
  end,
  formatters = {
    nasmfmt = { command = 'nasmfmt', args = { '$FILENAME' }, stdin = false },
    rumdl = { command = 'rumdl', args = { 'fmt', '-', '--quiet' }, stdin = true },
    shfmt = { prepend_args = { '-i', '2' } },
  },
}

vim.o.formatexpr = 'v:lua.require"conform".formatexpr()'

vim.api.nvim_create_user_command('FormatDisable', function(args)
  if args.bang then
    vim.b.disable_autoformat = true
  else
    vim.g.disable_autoformat = true
  end
end, { desc = 'Disable format on save', bang = true })

vim.api.nvim_create_user_command('FormatEnable', function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
end, { desc = 'Enable format on save' })

vim.keymap.set({ 'n', 'v' }, '<C-M-l>', function()
  conform.format { async = true, lsp_fallback = true }
end, { desc = 'Format buffer' })
