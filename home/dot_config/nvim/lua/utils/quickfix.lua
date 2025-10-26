-- -*-mode:lua-*- vim:ft=lua

-- local function toggle_qf_list()
--   for _, win in pairs(vim.fn.getwininfo()) do
--     if win["quickfix"] == 1 then
--       vim.cmd("cclose")
--       return
--     end
--   end
--   if not vim.tbl_isempty(vim.fn.getqflist()) then
--      vim.cmd("copen")
--   end
-- end

-- local function toggle_location_list()
--   for _, win in pairs(vim.fn.getwininfo()) do
--     if win["loclist"] == 1 then
--       vim.cmd("lclose")
--       return
--     end
--   end
--   if not vim.tbl_isempty(vim.fn.getloclist(0)) then
--     vim.cmd("lopen")
--   end
-- end

local function toggle_diagnostic_list()
  local items = vim.diagnostic.toqflist(vim.diagnostic.get(vim.api.nvim_get_current_buf()))
  vim.fn.setqflist(items)
  if vim.tbl_isempty(items) then
    vim.cmd.cclose()
  else
    vim.cmd.copen()
    vim.cmd.wincmd("p")
    -- vim.cmd.cc()
  end
end

vim.api.nvim_create_user_command("ToggleQuickfixList", function(_)
  require("quicker").toggle()
end, { desc = "Toggle Quickfix list", nargs = "*", bang = true })

vim.api.nvim_create_user_command("ToggleLocationList", function(_)
  require("quicker").toggle({ loclist = true })
end, { desc = "Toggle Location list", nargs = "*", bang = true })

vim.api.nvim_create_user_command("ToggleDiagnosticList", function(_)
  toggle_diagnostic_list()
end, { desc = "Toggle Diagnostic list", nargs = "*", bang = true })
