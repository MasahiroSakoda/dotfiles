-- -*-mode:lua-*- vim:ft=lua

---@param bufnr integer
---@param client vim.lsp.Client
local function sign_in(bufnr, client)
  client:request("signIn", vim.empty_dict(), function(err, result)
    if err then
      vim.notify(err.message, vim.log.levels.ERROR)
      return
    end
    if result.command then
      local code, command = result.userCode, result.command
      vim.fn.setreg("+", code)
      vim.fn.setreg("*", code)
      local continue = vim.fn.confirm(
        "Copied your one-time code to clipboard.\n" .. "Open the browser to complete sign-in process?", "&Yes\n&No"
      )
      if continue == 1 then
        client:exec_cmd(command, { bufnr = bufnr }, function(cmd_err, cmd_result)
          if cmd_err then
            vim.notify(err.message, vim.log.levels.ERROR)
            return
          end
          if cmd_result then
            vim.notify("Signed in as " .. cmd_result.user .. ".")
          end
        end)
      end
    end
    if result.status == "PromptUserDeviceFlow" then
      vim.notify("Enter your one-time code" .. result.userCode .. " in " .. result.verificationUri)
    elseif result.status == "AlreadySignedIn" then
      vim.notify("Already signed in as " .. result.user .. ".")
    end
  end)
end

---@param client vim.lsp.Client
local function sign_out(_, client)
  client:request("signOut", vim.empty_dict(), function(err, result)
    if err then
      vim.notify(err.message, vim.log.levels.ERROR)
      return
    end
    if result.status == "NotSignedIn" then
      vim.notify("Not signed in.")
    end
  end)
end

---@type vim.lsp.Config
return {
  cmd = { "copilot-language-server", "--stdio" },
  root_markers = { ".git" },
  init_options = {
    editorInfo       = { name = "NeoVim", version = tostring(vim.version()) },
    editorPluginInfo = { name = "NeoVim", version = tostring(vim.version()) },
  },
  settings = {
    telemetry = { enabled = false },
  },

  on_attach = function(client, bufnr)
    vim.lsp.inline_completion.enable()

    vim.api.nvim_buf_create_user_command(bufnr, "LspCopilotSignIn",  function() sign_in(bufnr, client)  end, {})
    vim.api.nvim_buf_create_user_command(bufnr, "LspCopilotSignOut", function() sign_out(bufnr, client) end, {})

    vim.keymap.set({ "i" }, "<C-CR>", vim.lsp.inline_completion.get, { desc = "Accept LSP inline suggestion" })
  end,
}
