-- -*-mode:lua-*- vim:ft=lua

---@type vim.lsp.Config
return {
  cmd          = { "taplo", "lsp", "stdio" },
  filetypes    = { "toml" },
  root_markers = { ".git" },
  settings = {
    evenBetterToml = {
      schema = {
        enabled = false,
        catalog = {
          "https://raw.githubusercontent.com/SchemaStore/schemastore/master/src/api/json/catalog.json",
          "https://taplo.tamasfe.dev/schema_index.json",
        },
      },
      formatter = {
        columnWidth       = 120,
        arrayAutoExpand   = true, -- Prevent array multi-line expansion
        arrayAutoCollapse = false, -- Automatically collapse arrays if they fit in one line.
        compactArrays     = true, -- Remove array whitespace
      },
      cachePath = vim.fn.stdpath("cache") .. "/taplo",
    },
  }
}
