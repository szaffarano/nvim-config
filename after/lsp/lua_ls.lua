---@type vim.lsp.Config
return {
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT' },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
          '${3rd}/luv/library',
        },
      },
      diagnostics = {
        globals = { 'vim', 'Org' },
      },
      telemetry = { enable = false },
    },
  },
}
