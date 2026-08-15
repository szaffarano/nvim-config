local api = vim.api

vim.pack.add {
  { src = 'https://github.com/neovim/nvim-lspconfig' },
}

vim.lsp.enable {
  'asm_lsp',
  'bashls',
  'clangd',
  'copilot',
  'dockerls',
  'fish_lsp',
  'gopls',
  'jinja_lsp',
  'jsonls',
  'ltex_plus',
  'lua_ls',
  'marksman',
  'nil_ls',
  'ruff',
  'taplo',
  'terraformls',
  'ts_ls',
  'ty',
  'yamlls',
  'zls',
}

vim.lsp.config('*', {
  capabilities = {
    general = { positionEncodings = { 'utf-16' } },
  },
})

vim.diagnostic.config {
  severity_sort = true,
  virtual_text = true,
  underline = true,
  update_in_insert = false,
  float = { border = 'rounded', source = true },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚 ',
      [vim.diagnostic.severity.WARN] = '󰀪 ',
      [vim.diagnostic.severity.INFO] = '󰋽 ',
      [vim.diagnostic.severity.HINT] = '󰌶 ',
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = 'ErrorMsg',
      [vim.diagnostic.severity.WARN] = 'WarningMsg',
    },
  },
}

api.nvim_create_autocmd('LspAttach', {
  group = api.nvim_create_augroup('my.lsp-attach', { clear = true }),
  callback = function(event)
    local buf = event.buf
    local keymap = vim.keymap
    local lsp_buf = vim.lsp.buf

    -- gd / gr / gI are handled by mini.extra pickers in after/plugin/mini.lua

    keymap.set('n', 'K', lsp_buf.hover, { buffer = buf, desc = 'Hover documentation' })
    keymap.set('n', 'gD', lsp_buf.declaration, { buffer = buf, desc = 'Go to declaration' })
    keymap.set('n', '<leader>lt', lsp_buf.type_definition, { buffer = buf, desc = 'Go to type definition' })
    keymap.set('n', '<leader>la', lsp_buf.code_action, { buffer = buf, desc = 'Code action' })
    keymap.set('n', '<leader>lr', lsp_buf.rename, { buffer = buf, desc = 'Rename symbol' })
    keymap.set('n', '<leader>ld', lsp_buf.document_symbol, { buffer = buf, desc = 'Document symbols' })
    keymap.set('n', '<leader>lw', lsp_buf.workspace_symbol, { buffer = buf, desc = 'Workspace symbols' })
    keymap.set('n', '<leader>li', function()
      local enabled = vim.lsp.inlay_hint.is_enabled { bufnr = buf }
      vim.lsp.inlay_hint.enable(not enabled, { bufnr = buf })
    end, { buffer = buf, desc = 'Toggle inlay hints' })

    local client = vim.lsp.get_client_by_id(event.data.client_id)

    if client and client.server_capabilities.documentHighlightProvider then
      local hl_group = api.nvim_create_augroup('my.lsp-highlight-' .. buf, { clear = true })
      api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = buf,
        group = hl_group,
        callback = lsp_buf.document_highlight,
      })
      api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = buf,
        group = hl_group,
        callback = lsp_buf.clear_references,
      })
    end

    -- signature help is handled by blink.cmp (signature = { enabled = true })
  end,
})
