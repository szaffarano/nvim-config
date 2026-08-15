vim.opt_local.spell = true
vim.opt_local.conceallevel = 2
vim.opt_local.concealcursor = 'c'
vim.opt_local.foldenable = true
vim.opt_local.foldlevel = 99

vim.bo.textwidth = 110

vim.wo[0][0].foldmethod = 'expr'
vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
