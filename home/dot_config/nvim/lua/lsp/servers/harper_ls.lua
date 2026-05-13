---@type vim.lsp.Config
return {
  cmd = { "harper-ls", "--stdio" },
  filetypes = require("user.filetypes").lsp.happer,
  single_file_support = true,
  capabilities = {
    semanticTokens = { multilineTokenSupport = true },
  },
  settings = {
    ["harper-ls"] = {
      diagnosticSeverity = "hint",
      ---@see https://writewithharper.com/docs/rules
      linters = {
        SpellCheck                   = false,
        Spaces                       = false,
        LongSentences                = false,
        ExpandAlloc                  = false,
        ExpandArgument               = false,
        ExpandControl                = false,
        ExpandDependencies           = false,
        ExpandForward                = false,
        ExpandMemoryShorthands       = false,
        ExpandMinimum                = false,
        ExpandParameter              = false,
        ExpandPointer                = false,
        ExpandPrevious               = false,
        ExpandStandardInputAndOutput = false,
        ExpandTimeShorthands         = false,
        ExpandThrough                = false,
        ExpandWith                   = false,
        ExpandWithout                = false,
        PhrasalVerbAsCompoundNoun    = false,
        SplitWords                   = false,
        ToDoHyphen                   = false,
        SentenceCapitalization       = true
      },
      markdown = { IgnoreLinkTitle = false },
      dialect = "American",
      maxFileLength = 120000,
      userDictPath = vim.fs.joinpath(vim.env.XDG_CONFIG_HOME, "harper", "dictionary.txt"),
      fileDictPath = "",
    },
  },
}
