local ok, navic = pcall(require, "nvim-navic")
if not ok then return end

navic.setup({
  icons = { -- VSCode style icon
    File          = ' ',
    Module        = ' ',
    Namespace     = ' ',
    Package       = ' ',
    Class         = ' ',
    Method        = ' ',
    Property      = ' ',
    Field         = ' ',
    Constructor   = ' ',
    Enum          = ' ',
    Interface     = ' ',
    Function      = ' ',
    Variable      = ' ',
    Constant      = ' ',
    String        = ' ',
    Number        = ' ',
    Boolean       = ' ',
    Array         = ' ',
    Object        = ' ',
    Key           = ' ',
    Null          = ' ',
    EnumMember    = ' ',
    Struct        = ' ',
    Event         = ' ',
    Operator      = ' ',
    TypeParameter = ' '
  },
  lsp = {
    auto_attach = true,
    preference = nil,
  },
  highlight = true,
  safe_output = true,
  separator = '',
  -- separator = '',
  depth_limit = 5,
  depth_limit_indicator = "..",
})
