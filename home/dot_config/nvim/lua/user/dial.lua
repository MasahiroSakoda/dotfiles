local dial_ok, dial     = pcall(require, "dial.config")
local augend_ok, augend = pcall(require, "dial.augend")
if not (dial_ok or augend_ok) then return end

dial.augends:register_group({
  default = {
    augend.integer.alias.decimal,
    augend.integer.alias.hex,
    augend.constant.alias.bool,
    augend.constant.new { elements = { "true", "false" }, word = true, cyclic = true, preserve_case = true },
    augend.date.alias["%m/%d/%Y"],
    augend.date.alias["%Y-%m-%d"],
    augend.date.alias["%m/%d/%Y"],
    augend.date.alias["%m/%d"],
    augend.date.alias["%H:%M"],
    augend.date.alias["%H:%M:%S"],
    augend.constant.alias.ja_weekday,
    augend.constant.alias.ja_weekday_full,

    augend.semver.alias.semver,
    augend.constant.new { elements = { "yes", "no" }, word = true, cyclic = true, preserve_case = true },
    augend.constant.new { elements = { "and", "or" }, word = true, cyclic = true, preserve_case = true },
    augend.constant.new { elements = { "&&", "||" }, word = false, cyclic = true },
    augend.constant.new { elements = { "==", "!=" }, word = false, cyclic = true },
    augend.constant.new { elements = { "public", "private" }, word = true, cyclic = true, preserve_case = true },
  },

  -- augend:on_filetype({
  --   lua = {
  --     augend.constant.new({ elements = { "==", "~=" }, word = false, cyclic = true }),
  --   },
  --   javascript = {
  --     augend.constant.new({ elements = { "===", "!==" }, word = false, cyclic = true }),
  --     augend.constant.new({ elements = { "let", "var", "const" }, word = false, cyclic = true }),
  --   },
  --   typescript = {
  --     augend.constant.new({ elements = { "===", "!==" }, word = false, cyclic = true }),
  --     augend.constant.new({ elements = { "let", "var", "const" }, word = false, cyclic = true }),
  --   },
  -- }),

  custom = {
    augend.integer.alias.decimal,
    augend.integer.alias.hex,
    augend.constant.alias.bool,
    augend.constant.new { elements = { "true", "false" }, word = true, cyclic = true, preserve_case = true },
    augend.constant.new { elements = { "prev", "next" },  word = true, cyclic = true, preserve_case = true },
    augend.constant.new { elements = { "open", "close" }, word = true, cyclic = true, preserve_case = true },
    augend.constant.new { elements = { "up", "down" },    word = true, cyclic = true, preserve_case = true },
    augend.constant.new { elements = { "ascending", "descending" }, word = true, cyclic = true },
    augend.constant.new { elements = { "horizontal", "vertical" },  word = true, cyclic = true },
    augend.constant.new { elements = { "top", "middle", "bottom" }, word = true, cyclic = true },
    augend.constant.new({
      elements = { "monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday" },
      word = true,
      cyclic = true,
      preserve_case = true,
    }),

    -- Font switcher
    augend.constant.new({ -- for ASCII font
      elements = {
        "JetBrainsMono Nerd Font Mono",
        "JetBrainsMonoNL Nerd Font Mono",
        "Hack Nerd Font Mono"
      },
      word = true,
      cyclic = true
    }),
    augend.constant.new({ -- for non ASCII font
      elements = {
        "HackGen Console NF",
        "HackGen Console NFJ",
        "PlemolJP Console NF",
        "PlemolJP Console NFJ",
      },
      word = true,
      cyclic = true
    }),
  },
})
