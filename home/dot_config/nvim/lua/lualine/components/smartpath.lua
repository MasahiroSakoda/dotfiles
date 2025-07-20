-- -*-mode:lua-*- vim:ft=lua
local lualine_require = require("lualine_require")
local modules = lualine_require.lazy_require({
  utils     = "lualine.utils.utils",
  highlight = "lualine.highlight",
})

local M  = require("lualine.component"):extend()
local hl_group = require("lualine.highlight").create_component_highlight_group

local palette = require("onedark.palette")[vim.g.themestyle]

local default_options = {
  status_symbols = { modified = "", readonly = "", newfile  = "", unnamed  = "" },
  colors  = {
    modified = {
      scope = { "fg" },
      syntaxlist = { "DiagnosticError", "LspDiagnosticsDefaultError", "DiffDelete" },
      default = palette.red,
    },
    readonly = {
      scope = { "fg" },
      syntaxlist = { "DiagnosticHint", "LspDiagnosticsDefaultHint", "DiffChange" },
      default = palette.dark_cyan,
    },
    newfile  = {
      scope = { "fg" },
      syntaxlist = { "DiagnosticInfo", "LspDiagnosticsDefaultInformation", "Normal" },
      default = palette.fg
    },
    unnamed  = {
      scope = { "fg" },
      syntaxlist = { "DiagnosticWarn", "LspDiagnosticsDefaultWarning", "DiffText" },
      default = palette.bg_yellow,
    },
  },
  colored        = true,

-- Smart path Options:
-- 0: l/l/s/init.lua
-- 1: l/l/servers/init.lua
-- 2: l/lsp/servers/init.lua
-- 3: lua/lsp/servers/init.lua
  parent_num     = 2, ---@type 0|1|2|3
  abbrev_dot     = true,
  file_status    = true,
  newfile_status = false,
  shorten_target = 40,
}

---@return boolean
local function is_new_file()
	local filename = vim.fn.expand("%")
	return filename ~= "" and vim.bo.buftype == "" and vim.fn.filereadable(filename) == 0
end

---@param dirname string
local function get_capital(dirname)
  return dirname:sub(1, 1)
end

---@param parts      string[] paths component
---@param parent_num integer  number of parent
---@param abbrev     boolean  abbrev with "" or not
---@return string
local function shorten_dirs(parts, parent_num, abbrev)
  local path = {}

  for i, part in ipairs(parts) do
    if i == 1 or i > #parts - parent_num then
      table.insert(path, part)
      table.insert(path, "/")
    else
      local abbrev_name = abbrev == true and get_capital(part) .. "" or get_capital(part)
      table.insert(path, abbrev_name)
      table.insert(path, "/")
    end
  end
  return table.concat(path)
end

---@param path_to_dir string filepath without filename
---@return string[]
local function split_dirs(path_to_dir)
  return vim.split(path_to_dir, "/", { trimempty = true })
end

function M:init(options)
  M.super.init(self, options)
  self.options = vim.tbl_deep_extend("keep", self.options or {}, default_options)

  self.highlights = {}
  for k, v in pairs(self.options.colors) do
    self.highlights[k] = self:create_hl(v, k)
  end
  self.icon_hl_cache = {}

  self.colors = {
    file     = hl_group({}, "filename_file",     self.options),
    dir      = hl_group({ fg = palette.dark_cyan, gui = "italic" }, "filename_dir",      self.options),
    modified = hl_group({ fg = palette.red,       gui = "italic" }, "filename_modified", self.options),
  }
end

function M:update_status()
  local dir_to_file = vim.fn.fnamemodify(vim.fn.expand("%:.:h"), ":r")
  local filename    = vim.fn.expand("%:t")
  local dirs        = split_dirs(dir_to_file)
  local display     = shorten_dirs(dirs, self.options.parent_num, self.options.abbrev_dot) .. filename

  local file_status = {
    unnamed  = not filename or filename == "",
    modified = vim.bo.modified,
    readonly = vim.bo.modifiable == false or vim.bo.readonly == true,
    newfile  = is_new_file()
  }

  local result = {}
  for k, v in pairs(file_status) do
    if v then
      local icon = self.options.status_symbols[k]
      if self.highlights[k] then
        icon = self:format_hl(self.highlights[k]) .. icon
      end
      table.insert(result, icon)
    end
  end

  if #result == 0 then
    return display
  end

  local status = table.concat(result, " ")
  if not display or display == "" then
    return status
  end
  return display .. " " .. status
end

function M:apply_icon()
  local filename = vim.fs.basename(vim.api.nvim_buf_get_name(0))
  local icon, icon_highlight_group = require("utils.icon").file_icon(filename, false)
  if icon == nil then
    return
  end

  if icon_highlight_group == nil then
    icon_highlight_group = "DevIconDefault"
  end

  local highlight_color = modules.utils.extract_highlight_colors(icon_highlight_group, "fg")
  if highlight_color then
    local icon_highlight = self.icon_hl_cache[highlight_color]
    if not icon_highlight or not modules.highlight.highlight_exists(icon_highlight.name .. "_normal") then
      icon_highlight = self:create_hl({ fg = highlight_color }, icon_highlight_group)
      self.icon_hl_cache[highlight_color] = icon_highlight
    end
    icon = self:format_hl(icon_highlight) .. icon .. self:get_default_hl()
  end
  self.status = icon .. " " .. self.status
end

return M
