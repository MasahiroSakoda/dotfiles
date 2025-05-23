-- -*-mode:lua-*- vim:ft=lua

local cmd = function()
  local code = nil
  local jid = vim.fn.jobstart(
    "grep -rl ruby-lsp --include Gemfile --include Gemfile.lock --include *.gemspec --exclude-dir .ruby-lsp .",
    { on_exit = function(_, data) code = data end }
  )
  vim.fn.jobwait({jid}, 5000)
  if code == 0 then return { "bundle", "exec", "ruby-lsp" } end
  return { "ruby-lsp" }
end

---@type vim.lsp.Config
return {
  cmd = cmd,
  filetypes    = { "ruby" },
  root_markers = require("user.filetypes").lsp.ruby,
  init_options = {
    enabledFeatures = {
      "documentHighlights",
      "documentSymbols",
      "documentLink",
      "foldingRanges",
      "selectionRanges",
      "semanticHighlighting",
      -- "formatting",
      -- "onTypeFormatting",
      "diagnostics",
      "signatureHelp",
      "codeActions",
      "codeActionResolve",
      "inlayHints",
      "completion",
      "codeLens",
    },
    formatter = "none", ---@type "none"|"rubocop"
  },
  settings = {},
  -- commands = {
  --   FormatRuby = {
  --     function()
  --       vim.lsp.buf.format({
  --         name = "ruby_lsp",
  --         async = true,
  --       })
  --     end,
  --     description = "Format using ruby-lsp",
  --   },
  -- },
}
