local telescope_ok, telescope = pcall(require, "telescope")
local actions_ok, actions     = pcall(require, "telescope-live-grep-args.actions")
if not (telescope_ok or actions_ok) then return end

telescope.setup({
  extensions = {
    live_grep_args = {
      auto_quoting = true,
      mappings = {
        i = {
          ["<C-r>"] = actions.quote_prompt(),
          ["<C-i>"] = actions.quote_prompt({ postfix = " --iglob " }),
        },
      },
    },
  },
})
