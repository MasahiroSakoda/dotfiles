local telescope_ok, telescope = pcall(require, "telescope")
local actions_ok,     actions = pcall(require, "telescope._extensions.egrepify.actions")

if not (telescope_ok or actions_ok) then return end

telescope.setup({
  extensions = {
    egrepify = {
      prefixes = {
        ["!"] = {
          flag = "invert-match",
        },
      },

      mappings = {
        i = {
          -- toggle prefixes, prefixes is default
          ["<C-z>"] = actions.toggle_prefixes,
          -- toggle AND, AND is default, AND matches tokens and any chars in between
          ["<C-a>"] = actions.toggle_and,
          -- toggle permutations, permutations of tokens is opt-in
          ["<C-r>"] = actions.toggle_permutations,
        }
      },
    },
  },
})
