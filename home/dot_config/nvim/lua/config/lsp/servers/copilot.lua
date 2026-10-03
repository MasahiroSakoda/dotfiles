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
  -- Exclude specific filetype patterns
  root_dir = function(bufnr, callback)
    local patterns = { "^.*%.local", "^%.env.*", "^%.secrets?.*" }
    local disabled = vim.iter(patterns):any(function(pattern)
      return string.match(vim.fs.basename(vim.api.nvim_buf_get_name(bufnr)), pattern)
    end)
    if disabled then
      return
    end

    local root_dir = vim.fs.root(bufnr, { ".git" })
    if root_dir then
      callback(root_dir)
    end
  end,
  init_options = {
    editorInfo       = { name = "NeoVim", version = tostring(vim.version()) },
    editorPluginInfo = { name = "NeoVim", version = tostring(vim.version()) },
  },
  settings = {
    telemetry = { telemetryLevel = "off" },
  },

  on_init = function(client, _)
    -- Highlight suggestion
    local hlc = vim.api.nvim_get_hl(0, { name = "Comment" })
    local hlm = vim.api.nvim_get_hl(0, { name = "MoreMsg" })
    vim.api.nvim_set_hl(0, "CompHint",     vim.tbl_extend("force", hlc, { underline = true }))
    vim.api.nvim_set_hl(0, "CompHintMore", vim.tbl_extend("force", hlm, { underline = true }))

    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(ev)
        if vim.version().minor < 12 then
          return
        end

        local bufnr = ev.buf
        -- Configure Sign in / out
        vim.api.nvim_buf_create_user_command(bufnr, "LspCopilotSignIn",  function() sign_in(bufnr,  client)  end, {})
        vim.api.nvim_buf_create_user_command(bufnr, "LspCopilotSignOut", function() sign_out(bufnr, client) end, {})

        -- Keymaps for attached buffer
        if client:supports_method(vim.lsp.protocol.Methods.textDocument_inlineCompletion, bufnr) then
          -- Enable inline completion
          vim.schedule(function()
            vim.lsp.inline_completion.enable(true, { bufnr = bufnr })
          end)
          vim.keymap.set("i", "<C-CR>", vim.lsp.inline_completion.get())
          vim.keymap.set("i", "<C-f>",  vim.lsp.inline_completion.select({ bufnr = bufnr, count = 1 }))
          vim.keymap.set("i", "<C-b>",  vim.lsp.inline_completion.select({ bufnr = bufnr, count = -1 * vim.v.count1 }))
        end
      end,
    })
  end,
}
