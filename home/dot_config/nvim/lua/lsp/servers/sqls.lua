---@type vim.lsp.Config
return {
  cmd = { "sqls" },
  filetypes = { "sql", "mysql" },
  root_markers = { ".sqls.yml", ".sqlsrc.yml" },
  settings = {
    sqls = {
      connections = {
        -- {
        --   driver = "mysql",
        --   dataSourceName = "root:root@tcp(127.0.0.1:13306)/world",
        -- },
        -- {
        --   driver = "postgresql",
        --   dataSourceName = "host=127.0.0.1 port=15432 user=postgres password=password dbname=sample sslmode=disable"
        -- },
      },
    },
  },
}
