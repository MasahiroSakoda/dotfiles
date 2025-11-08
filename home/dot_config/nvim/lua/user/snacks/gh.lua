-- -*-mode:lua-*- vim:ft=lua

---@class snacks.gh.Config
return {
  enable = true,

  keys = {
    select  = { "<cr>", "gh_actions", desc = "Select Action" },
    edit    = { "i"   , "gh_edit"   , desc = "Edit" },
    comment = { "a"   , "gh_comment", desc = "Add Comment" },
    close   = { "c"   , "gh_close"  , desc = "Close" },
    reopen  = { "o"   , "gh_reopen" , desc = "Reopen" },
  },
}
