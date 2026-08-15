if vim.g.lazydev_setup then
  return
end
vim.g.lazydev_setup = true

vim.pack.add {
  { src = 'https://github.com/folke/lazydev.nvim' },
}

require('lazydev').setup {
  library = {
    { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
    { path = 'blink.lib', words = { 'blink%.lib' } },
  },
}
