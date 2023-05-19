return function()
  -- PERF: no need to load the plugin, if we only need its queries for mini.ai
  local plugin = require("lazy.core.config").spec.plugins["nvim-treesitter"]
  local opts = require("lazy.core.plugin").values(plugin, "opts", false)
  local enabled = false
  if opts.textobjects then
    for _, mod in ipairs({ "move", "select", "swap", "lsp_interop" }) do
      if opts.textobjects[mod] and opts.textobjects[mod].enable then
        enabled = true
        break
      end
    end
  end
  if not enabled then
    require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
  end
end
