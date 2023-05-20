local ok, lspconfig = pcall(require, "lspconfig")
if not ok then return end

local util = lspconfig.util
local cmd  = { "vscode-eslint-language-server", "--stdio" }

local function fix_all(opts)
  opts = opts or {}

  local eslint_lsp_client = util.get_active_client_by_name(opts.bufnr, 'eslint')
  if eslint_lsp_client == nil then
    return
  end

  local request
  if opts.sync then
    request = function(bufnr, method, params)
      eslint_lsp_client.request_sync(method, params, nil, bufnr)
    end
  else
    request = function(bufnr, method, params)
      eslint_lsp_client.request(method, params, nil, bufnr)
    end
  end

  local bufnr = util.validate_bufnr(opts.bufnr or 0)
  request(0, 'workspace/executeCommand', {
    command = 'eslint.applyAllFixes',
    arguments = {
      {
        uri = vim.uri_from_bufnr(bufnr),
        version = util.buf_versions[bufnr],
      },
    },
  })
end

return {
  cmd       = cmd,
  root_dir  = function(filename)
    return util.root_pattern(
      ".eslintrc",
      ".eslintrc.js",
      ".eslintrc.cjs",
      ".eslintrc.json",
      ".eslintrc.yml",
      ".eslintrc.yaml",
      "package.json",
      "src")(filename) or vim.fn.getcwd()
  end,
  filetypes = {
    "javascript",
    "javascript.jsx",
    "javascriptreact",
    "typescript",
    "typescript.tsx",
    "typescriptreact",
    "vue",
  },
  settings = {
    validate = "on",
    packageManager = "npm",
    useESLintClass = false,
    codeActionOnSave = {
      enable = false,
      mode = "all",
    },
    format = true,
    quiet  = false,
    onIgnoredFiles = "off",
    rulesCustomizations = {},
    run = "onType",
    nodePath = "",
    workingDirectory = { mode = "location" },
    codeAction = {
      disableRuleComment = {
        enable   = true,
        location = "separateLine",
      },
      showDocumentation = {
        enable = true,
      },
    },
  },
  on_new_config = function(config, new_root_dir)
    config.settings.workspaceFolder = {
      uri = new_root_dir,
      name = vim.fn.fnamemodify(new_root_dir, ':t'),
    }

    -- Support Yarn2 (PnP) projects
    local pnp_cjs = util.path.join(new_root_dir, '.pnp.cjs')
    local pnp_js  = util.path.join(new_root_dir, '.pnp.js')
    if util.path.exists(pnp_cjs) or util.path.exists(pnp_js) then
      config.cmd = vim.list_extend({ 'yarn', 'exec' }, cmd)
    end
  end,
  handlers = {
    ['eslint/openDoc'] = function(_, result)
      if not result then
        return
      end
      local sysname = vim.loop.os_uname().sysname
      if sysname:match 'Windows' then
        os.execute(string.format('start %q', result.url))
      elseif sysname:match 'Linux' then
        os.execute(string.format('xdg-open %q', result.url))
      else
        os.execute(string.format('open %q', result.url))
      end
      return {}
    end,
    ['eslint/confirmESLintExecution'] = function(_, result)
      if not result then
        return
      end
      return 4 -- approved
    end,
    ['eslint/probeFailed'] = function()
      vim.notify('[lspconfig] ESLint probe failed.', vim.log.levels.WARN)
      return {}
    end,
    ['eslint/noLibrary'] = function()
      vim.notify('[lspconfig] Unable to find ESLint library.', vim.log.levels.WARN)
      return {}
    end,
  },
  commands = {
    EslintFixAll = {
      function()
        fix_all { sync = true, bufnr = 0 }
      end,
      description = 'Fix all eslint problems for this buffer',
    },
  },
}
