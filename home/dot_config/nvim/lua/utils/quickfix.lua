-- -*-mode:lua-*- vim:ft=lua

local function toggle_qf_list()
  for _, win in pairs(vim.fn.getwininfo()) do
    if win["quickfix"] == 1 then
      vim.cmd("cclose")
      return
    end
  end
  if not vim.tbl_isempty(vim.fn.getqflist()) then
     vim.cmd("copen")
  end
end

local function toggle_location_list()
  for _, win in pairs(vim.fn.getwininfo()) do
    if win["loclist"] == 1 then
      vim.cmd("lclose")
      return
    end
  end
  if not vim.tbl_isempty(vim.fn.getloclist(0)) then
    vim.cmd("lopen")
  end
end

vim.api.nvim_create_user_command("ToggleQuickfixList", function(_)
  toggle_qf_list()
end, { desc = "Toggle Quickfix list", nargs = "*", bang = true })

vim.api.nvim_create_user_command("ToggleLocationList", function(_)
  toggle_location_list()
end, { desc = "Toggle Location list", nargs = "*", bang = true })
