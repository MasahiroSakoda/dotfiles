-- -*-mode:lua-*- vim:ft=lua

local function reload_workspace(bufnr)
  local clients = vim.lsp.get_clients { bufnr = bufnr, name = "rust_analyzer" }
  for _, client in ipairs(clients) do
    vim.notify "Reloading Cargo Workspace"
    ---@diagnostic disable-next-line:param-type-mismatch
    client:request("rust-analyzer/reloadWorkspace", nil, function(err)
      if err then
        error(tostring(err))
      end
      vim.notify "Cargo workspace reloaded"
    end, 0)
  end
end

local function is_library(fname)
  local user_home    = vim.fs.normalize(vim.env.HOME)
  local cargo_home   = os.getenv "CARGO_HOME" or user_home .. "/.cargo"
  local registry     = cargo_home .. "/registry/src"
  local git_registry = cargo_home .. "/git/checkouts"

  local rustup_home = os.getenv "RUSTUP_HOME" or user_home .. "/.rustup"
  local toolchains  = rustup_home .. "/toolchains"

  for _, item in ipairs { toolchains, registry, git_registry } do
    if vim.fs.relpath(item, fname) then
      local clients = vim.lsp.get_clients { name = "rust_analyzer" }
      return #clients > 0 and clients[#clients].config.root_dir or nil
    end
  end
end

---@type vim.lsp.Config
return {
  cmd       = { "rust-analyzer" },
  filetypes = { "rust" },
  root_dir  = function(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)
    local reused_dir = is_library(fname)
    if reused_dir then
      on_dir(reused_dir)
      return
    end

    local cargo_crate_dir = vim.fs.root(fname, { "Cargo.toml" })
    local cargo_workspace_root

    if cargo_crate_dir == nil then
      on_dir(
        vim.fs.root(fname, { "rust-project.json" })
        or vim.fs.dirname(vim.fs.find(".git", { path = fname, upward = true })[1])
      )
      return
    end

    local cmd = {
      "cargo",
      "metadata",
      "--no-deps",
      "--format-version",
      "1",
      "--manifest-path",
      cargo_crate_dir .. "/Cargo.toml",
    }

    vim.system(cmd, { text = true }, function(output)
      if output.code == 0 then
        if output.stdout then
          local result = vim.json.decode(output.stdout)
          if result["workspace_root"] then
            cargo_workspace_root = vim.fs.normalize(result["workspace_root"])
          end
        end

        on_dir(cargo_workspace_root or cargo_crate_dir)
      else
        vim.schedule(function()
          vim.notify(("[rust_analyzer] cmd failed with code %d: %s\n%s"):format(output.code, cmd, output.stderr))
        end)
      end
    end)
  end,
  capabilities = {
    experimental = {
      serverStatusNotificaiton = true,
      commands = {
        commands = { "rust-analzer.showReferences", "rust-analzer.runSingle", "rust-analzer.debugSingle" },
      },
    },
  },
  settings  = {
    -- Refer to all available options here: https://rust-analyzer.github.io/manual.html
    ["rust-analyzer"] = {
      cargo = { { buildScripts = { enable = true } } },
      imports = { granularity = { group = "module" }, prefix = "self" },
      procMacro = { enable = true },
      completion = {
        autoimport = { enable = true },
        postfix    = { enable = true },
        fullFunctionSignatures = { enable = true },
      },
      assist = {
        importEnforceGranularity = true,
        importPrefix = "crate",
      },
      checkOnSave = {
        allFeatures = true,
        command     = "clippy",
        extraArgs   = { "--no-deps" },
      },
      diagnostics = {
        experimental = { enable = true },
        disabled = { "unresolved-proc-macro" },
      },
      hover = {
        actions = { references = { enable = true } },
      },
      lens = {
        enable        = true,
        debug         = { enable = true },
        implementions = { enable = true},
        run           = { enabled = true },
        updateTest    = { enable = true },
        references = {
          adt         = { enable = true },
          enumVariant = { enable = true },
          method      = { enable = true },
          trait       = { enable = true },
        },
      },
      inlayHints = {
        locationLinks = false,
        lifetimeElisionHints = {
          enable = "always", ---@type "always"|"never"
          useParameterNames = true,
        },
      },
    }
  },
  before_init = function(init_params, config)
    if config.settings and config.settings["rust-analyzer"] then
      init_params.initializationOptions = config.settings["rust-analyzer"]
    end
    ---@param command table{ title: string, command: string, arguments: any[] }
    vim.lsp.commands["rust-analyzer.runSingle"] = function(command)
      local r   = command.arguments[1]
      local cmd = { "cargo", unpack(r.args.cargoArgs) }
      if r.args.executableArgs and #r.args.executableArgs > 0 then
        vim.list_extend(cmd, { "--", unpack(r.args.executableArgs) })
      end

      local proc   = vim.system(cmd, { cwd = r.args.cwd })
      local result = proc:wait()

      if result.code == 0 then
        vim.notify(result.stdout, vim.log.levels.INFO)
      else
        vim.notify(result.stderr, vim.log.levels.ERROR)
      end
    end
  end,
  on_attach = function(_, bufnr)
    vim.api.nvim_buf_create_user_command(bufnr, "LspCargoReload", function()
      reload_workspace(bufnr)
    end, { desc = "Reload current cargo workspace" })
  end,
}
