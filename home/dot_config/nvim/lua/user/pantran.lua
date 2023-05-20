local pantran_ok, pantran = pcall(require, "pantran")
local actions_ok, actions = pcall(require, "pantran.ui.actions")
local engines_ok, engines = pcall(require, "pantran.engines")
local async_ok, async     = pcall(require, "pantran.async")
if not (pantran_ok or actions_ok or engines_ok or async_ok) then return end

pantran.setup({
  retry = 5,
  timeout = 20,

  default_engine = "google",
  engines = {
    deepl = {
      default_target = "JA-JP",
    },
    google = {
      fallback = {
        default_source = "auto",
        default_target = "ja",
      },
    },
    argos = {
      default_source = "auto",
      default_target = "ja",
    },
  },

  controls = {
    mappings = {
      edit = {
        n = {
          ["j"] = "gj",
          ["k"] = "gk",
        },
        i = {
          ["<C-c>"] = actions.close,
        },
      },
      select = {
        n = {
        },
        i = {
        },
      },
    }
  },
})
