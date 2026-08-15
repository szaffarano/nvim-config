---@type vim.lsp.Config
return {
  cmd = { 'ruff', 'server' },
  filetypes = { 'python' },
  root_markers = { 'pyproject.toml', 'ruff.toml', '.ruff.toml', '.git' },
  -- TODO: review https://docs.astral.sh/ruff/editors/setup/
  -- init_options = {
  -- settings = {
  -- Ruff language server settings go here
  -- }
  -- }
}
