local ok, codicons = pcall(require, "codicons")
if not ok then return end

codicons.setup({})

require("codicons.extensions.completion_item_kind")
require("codicons.extensions.vs_code_product_icons")

vim.g.vim_package_info_virutaltext_prefix = "  " .. codicons.get("versions", "icon") .. " "
