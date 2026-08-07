---@type vim.lsp.Config
return {
  cmd      = { "vtsls", "--stdio" },
  filetypes= { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  root_dir = function(bufnr, on_dir)
    local root_markers = { "package-lock.json", "yarn.lock", "pnpm-lock.yaml", "bun.lock" }
    root_markers = vim.fn.has("nvim-0.11.3") == 1 and { root_markers, { ".git" } }
      or vim.list_extend(root_markers, { ".git" })
    local deno_path = vim.fs.root(bufnr, { "deno.json", "deno.jsonc", "deno.lock" })
    local project_root = vim.fs.root(bufnr, root_markers)
    if deno_path and (not project_root or #deno_path >= #project_root) then
      return
    end
    on_dir(project_root or vim.fn.getcwd())
  end,

  single_file_support = true,
}
