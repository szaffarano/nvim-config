---@type vim.lsp.Config
return {
  root_markers = { 'build.zig', 'build.zig.zon' },
  settings = {
    zls = {
      warn_style = true,
      highlight_global_var_declarations = true,
      inlay_hints_hide_redundant_param_names = true,
      inlay_hints_hide_redundant_param_names_last_token = true,
    },
  },
}
