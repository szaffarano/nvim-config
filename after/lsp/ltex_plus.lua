---@type vim.lsp.Config
return {
  filetypes = { 'gitcommit', 'mail', 'markdown', 'org', 'pandoc', 'rst', 'tex' },
  settings = {
    ltex = {
      language = { 'en-US', 'es-AR' },
      checkFrequency = 'save',
      diagnosticSeverity = 'information',
      sentenceCacheSize = 2000,
      additionalRules = {
        enablePickyRules = true,
        motherTongue = 'es-AR',
        languageModel = '~/Documents/n-grams',
      },
    },
  },
}
