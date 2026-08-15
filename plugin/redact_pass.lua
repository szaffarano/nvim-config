-- Disable leaky options when editing a password file via pass(1).
-- Ported from: https://git.zx2c4.com/password-store/tree/contrib/vim

if vim.g.loaded_redact_pass or vim.o.compatible then
  return
end
vim.g.loaded_redact_pass = 1

local function check_args_redact()
  if vim.fn.argc() ~= 1 or vim.fn.fnamemodify(vim.fn.argv(0), ':p') ~= vim.fn.expand '<afile>:p' then
    return
  end

  vim.o.backup = false
  vim.o.writebackup = false
  vim.o.swapfile = false
  vim.o.viminfo = ''
  if vim.fn.has 'persistent_undo' == 1 then
    vim.o.undofile = false
  end

  vim.notify('Editing password file--disabled leaky options!', vim.log.levels.INFO)
  vim.g.redact_pass_redacted = 1
end

local group = vim.api.nvim_create_augroup('redact_pass', { clear = true })
vim.api.nvim_create_autocmd('VimEnter', {
  group = group,
  pattern = {
    '/dev/shm/pass.?*/?*.txt',
    '/dev/shm/gopass*/secret',
    '$TMPDIR/pass.?*/?*.txt',
    '/tmp/pass.?*/?*.txt',
  },
  callback = check_args_redact,
})
