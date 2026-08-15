vim.pack.add {
  { src = 'https://github.com/saghen/blink.lib' },
  { src = 'https://github.com/fang2hou/blink-copilot' },
  { src = 'https://github.com/saghen/blink.cmp' },
}

local cmp = require 'blink.cmp'
cmp.build():pwait()

local default_sources = { 'lsp', 'copilot', 'path', 'snippets', 'buffer', 'cmdline', 'omni' }

---@module 'blink.cmp'
---@type blink.cmp.Config
cmp.setup {
  keymap = {
    preset = 'default',
    ['<Tab>'] = { 'snippet_forward', 'fallback' },
    ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
  },

  snippets = { preset = 'mini_snippets' },

  cmdline = {
    enabled = true,
    keymap = { preset = 'cmdline', ['<Tab>'] = false },
  },

  appearance = { nerd_font_variant = 'mono' },

  completion = {
    ghost_text = { enabled = true },
    documentation = { auto_show = true },
    menu = {
      draw = {
        columns = { { 'label', 'label_description', gap = 1 }, { 'kind_icon', 'kind' } },
      },
    },
  },

  signature = { enabled = true },

  sources = {
    default = default_sources,
    per_filetype = {
      org = vim.list_extend(vim.deepcopy(default_sources), { 'orgmode' }),
    },
    providers = {
      copilot = {
        name = 'Copilot',
        module = 'blink-copilot',
        score_offset = 100,
        async = true,
        opts = {
          max_completions = 10,
          max_attempts = 4,
          debug = true,
        },
      },
      orgmode = {
        name = 'Orgmode',
        module = 'orgmode.org.autocompletion.blink',
        fallbacks = { 'buffer' },
      },
    },
  },

  fuzzy = { implementation = 'prefer_rust' },
}
