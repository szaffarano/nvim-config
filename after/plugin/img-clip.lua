vim.pack.add {
  { src = 'https://github.com/HakonHarnes/img-clip.nvim' },
}

require('img-clip').setup {
  default = {
    dir_path = 'assets',
    file_name = '%Y-%m-%d-%H-%M-%S',
    use_absolute_path = false,
    relative_to_current_file = true,
  },
  filetypes = {
    org = {
      template = '[[file:$FILE_PATH]]',
      dir_path = function()
        return vim.fn.expand '%:p:h' .. '/assets'
      end,
    },
    markdown = {
      template = '![]($FILE_PATH)',
    },
  },
}

vim.keymap.set('n', '<leader>pi', '<cmd>PasteImage<cr>', { desc = 'Paste image from clipboard' })
