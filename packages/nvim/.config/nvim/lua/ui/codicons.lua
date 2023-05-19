local ok, codicons = pcall(require, "codicons")
if not ok then return end

codicons.setup()

local extensions = require("codeicons.extensions").available()
require(extensions.CompletionItemKind).set()
require(extensions.VSCodeProductIcons).set()

vim.g.vim_package_info_virutaltext_prefix = "  " .. codicons.get("versions") .. " "
