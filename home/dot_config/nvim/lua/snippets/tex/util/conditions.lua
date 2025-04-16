-- -*-mode:lua-*- vim:ft=lua
local M = {}

---@param name string environment name
---@return boolean
local function in_env(name)
  local is_inside = vim.fn["vimtex#env#is_inside"](name)
  return (is_inside[1] > 0 and is_inside[2] > 0)
end

---@return boolean
function M.in_math()
  return vim.api.nvim_eval("vimtex#syntax#in_mathzone()") == 1
end

---@return boolean
function M.in_comment()
  return vim.fn["vimtex#syntax#in_comment"]() == 1
end

---@return boolean
function M.in_beamer()
	return vim.b.vimtex["documentclass"] == "beamer"
end

---@return boolean
function M.in_preamble()
	return not in_env("document")
end

---@return boolean
function M.in_text()
	return in_env("document") and not M.in_math()
end

---@return boolean
function M.in_itemize()
  return in_env("itemize")
end

---@return boolean
function M.in_bullets()
	return in_env("itemize") or in_env("enumerate")
end

---@return boolean
function M.in_align()
  return in_env("align") or in_env("align*") or in_env("aligned")
end

return M
