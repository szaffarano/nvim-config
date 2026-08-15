---@type table<string, { indent?: boolean, aliases?: string[] }>
local languages = {
  c = { indent = true },
  cpp = { indent = true },
  fish = { aliases = { 'sh', 'zsh' } },
  go = {},
  ini = {},
  java = {},
  kotlin = {},
  json = {},
  lua = { indent = true },
  markdown = {},
  markdown_inline = {},
  nix = {},
  python = {},
  rust = {},
  sql = {},
  terraform = {},
  toml = { indent = true },
  typescript = {},
  yaml = {},
}

-- filetypes we deliberately have no parser for; don't warn about them
---@type table<string, boolean>
local ignored_languages = {
  oil = true,
  orgagenda = true,
  qf = true,
  text = true,
}

local group = vim.api.nvim_create_augroup('my.treesitter', { clear = true })

vim.pack.add { 'https://github.com/nvim-treesitter/nvim-treesitter' }

require('nvim-treesitter').install 'stable'
-- just in case I want to add a non-stable language
require('nvim-treesitter').install(vim.tbl_keys(languages))

for lang, opts in pairs(languages) do
  if opts.aliases then
    vim.treesitter.language.register(lang, opts.aliases)
  end
end

vim.api.nvim_create_autocmd('FileType', {
  group = group,
  desc = 'Treesitter: highlight + folds (+ indent where it wins)',
  callback = function(ev)
    local ok = pcall(vim.treesitter.start, ev.buf)
    if not ok then
      local ft = vim.bo[ev.buf].filetype
      -- only warn for real files, not UI/scratch buffers
      if vim.bo[ev.buf].buftype == '' and ft ~= '' and not ignored_languages[ft] then
        vim.notify_once(('treesitter: no parser for filetype "%s"'):format(ft), vim.log.levels.WARN)
      end
      return
    end

    vim.wo[0][0].foldmethod = 'expr'
    vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'

    local lang = vim.treesitter.language.get_lang(vim.bo[ev.buf].filetype)
    if lang and languages[lang] and languages[lang].indent then
      vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})

vim.api.nvim_create_autocmd('PackChanged', {
  group = group,
  desc = 'Treesitter: rebuild parsers after plugin update',
  callback = function(ev)
    if ev.data.spec.name == 'nvim-treesitter' and ev.data.kind == 'update' then
      require('nvim-treesitter').update()
    end
  end,
})
