-- -*-mode:lua-*- vim:ft=lua
if vim.b.current_syn then
  return
end

local cpo_save = vim.opt.cpoptions:get()
vim.cmd([[set cpoptions&vim]])

-- Operators
--------------------------------------------------------------------------------
vim.cmd([[syn match logOperator   display '[;,\?\:\.\<=\>\~\/\@\!$\%&\+\-\|\^(){}\*#]']])
vim.cmd([[syn match logBrackets   display /\[\|\]/]])
vim.cmd([[syn match logEmptyLines display '-\{3,}']])
vim.cmd([[syn match logEmptyLines display '\*\{3,}']])
vim.cmd([[syn match logEmptyLines display '=\{3,}']])
vim.cmd([[syn match logEmptyLines display '- - ']])

-- Constants
--------------------------------------------------------------------------------
vim.cmd([[syn match logNumber       '\<-\?\d\+\>']])
vim.cmd([[syn match logHexNumber    '\<\x\+\>']])
vim.cmd([[syn match logBinaryNumber '\<0[bB][01]\+\>']])
vim.cmd([[syn match logFloatNumber  '\<\d.\d\+[eE]\?\>']])

vim.cmd([[syn keyword logBoolean TRUE FALSE True False true false]])
vim.cmd([[syn keyword logNull    NULL Null null]])

vim.cmd([[syn region logString start=/"/ end=/"/ end=/$/ skip=/\\./]])
vim.cmd([[syn region logString start=/'\(s \|t \| \w\)\@!/ end=/'/ end=/$/ end=/s / skip=/\\./]])

-- Dates & Times
--------------------------------------------------------------------------------
vim.cmd([[
syn match logDate '\d\{2,4}[-\/]\(\d\{2}\|Jan\|Feb\|Mar\|Apr\|May\|Jun\|Jul\|Aug\|Sep\|Oct\|Nov\|Dec\)[-\/]\d\{2,4}T\?'
]])
vim.cmd([[syn match logDate /^(19|20)\d\{6}/]])
vim.cmd([[
syn keyword logDate Sun Mon Tue Wed Thu Fri Sat Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec nextgroup=logDateDay
]])
vim.cmd([[syn match logDateDay '\s\{1,2}\d\{1,2}' contained]])
vim.cmd([[syn match logTime '\(\.\d\{2,6}\)\?\(\s\?[-+]\d\{2,4}\|Z\)\?\>' nextgroup=logTimeZone,logSysCol skipwhite]])
vim.cmd([[syn match logTime /\d\{2}:\d\{2}:\d\{2}/]])
vim.cmd([[syn match logTimeZone '[A-Z]\{2,5}\>\( \d\{4}\)\?' contained]])
vim.cmd([[syn match logTimeZone '\d\{4} [A-Z]\{2,5}\>'       contained]])

-- Entries
--------------------------------------------------------------------------------
vim.cmd([[syn match logUrl        /http[s]\?:\/\/[^\n|,; '"]\+/]])
vim.cmd([[syn match logDomain     /\v(^|\s)(\w|-)+(\.(\w|-)+)+\s/]])
vim.cmd([[syn match logUUID       /\w\{8}-\w\{4}-\w\{4}-\w\{4}-\w\{12}/]])
vim.cmd([[syn match logMD5        /[a-z0-9]\{32}/]])
vim.cmd([[syn match logIPv4       /\d\{1,3}\(\.\d\{1,3}\)\{3}/]])
vim.cmd([[syn match logIPv6       /\x\{1,4}\(:\x\{1,4}\)\{7}/]])
vim.cmd([[syn match logMacAddress /\x\{2}\(:\x\{2}\)\{5}/]])
vim.cmd([[syn match logFilePath   /\w:\[^\n|,; ()'"\]{}]\+/]])
vim.cmd([[syn match logFilePath   /[^a-zA-Z0-9"']\@<=\/\w[^\n|,; ()'"\]{}]\+/]])

vim.cmd([[syn match logMailHeader  /^\(From\|To\|Cc\|Subject\|Date\):/]])
vim.cmd([[syn match logMailAddress /<[^>]\+@[^>]\+>/]])
vim.cmd([[syn match logMailAddress /[a-zA-Z0-9._%+-]\+@[a-zA-Z0-9.-]\+\.[a-zA-Z]\{2,}/]])
vim.cmd([[syn match logMailQuoted  /^>.*$/]])

-- Syslog Columns
--------------------------------------------------------------------------------
vim.cmd([[
syn match logSysCol '\w\(\w\|\.\|-\)\+ \(\w\|\.\|-\)\+\(\[\d\+\]\)\?:' contains=logOperator,logSysProc contained
]])
vim.cmd([[syn match logSysProc '\(\w\|\.\|-\)\+\(\[\d\+\]\)\?:' contains=logOperator,logNumber,logBrackets contained]])

---Levels
--------------------------------------------------------------------------------
vim.cmd([[syn keyword logLevelEmerg  EMERGENCY EMERG]])
vim.cmd([[syn keyword logLevelAlert  ALERT]])
vim.cmd([[syn keyword logLevelCrit   CRITICAL CRIT FATAL]])
vim.cmd([[syn keyword logLevelError  ERROR ERR FAILURE SEVERE]])
vim.cmd([[syn keyword logLevelWarn   WARNING WARN]])
vim.cmd([[syn keyword logLevelNotice NOTICE]])
vim.cmd([[syn keyword logLevelInfo   INFO]])
vim.cmd([[syn keyword logLevelDebug  DEBUG FINE]])
vim.cmd([[syn keyword logLevelTrace  TRACE FINER FINEST]])

-- Highlight
--------------------------------------------------------------------------------
vim.api.nvim_set_hl(0, "logNumber",       { link = "Number",   default = true })
vim.api.nvim_set_hl(0, "logHexNumber",    { link = "Number",   default = true })
vim.api.nvim_set_hl(0, "logBinaryNumber", { link = "Number",   default = true })
vim.api.nvim_set_hl(0, "logFloatNumber",  { link = "Float",    default = true })
vim.api.nvim_set_hl(0, "logBoolean",      { link = "Boolean",  default = true })
vim.api.nvim_set_hl(0, "logNull",         { link = "Constant", default = true })
vim.api.nvim_set_hl(0, "logString",       { link = "String",   default = true })

vim.api.nvim_set_hl(0, "logDate",     { link = "Identifier", default = true })
vim.api.nvim_set_hl(0, "logDateDay",  { link = "Identifier", default = true })
vim.api.nvim_set_hl(0, "logTime",     { link = "Identifier", default = true })
vim.api.nvim_set_hl(0, "logTimeZone", { link = "Identifier", default = true })

vim.api.nvim_set_hl(0, "logUrl",         { link = "Underlined",  default = true })
vim.api.nvim_set_hl(0, "logDomain",      { link = "Label",       default = true })
vim.api.nvim_set_hl(0, "logUUID",        { link = "Label",       default = true })
vim.api.nvim_set_hl(0, "logMD5",         { link = "Label",       default = true })
vim.api.nvim_set_hl(0, "logIPv4",        { link = "Label",       default = true })
vim.api.nvim_set_hl(0, "logIPv6",        { link = "ErrorMsg",    default = true })
vim.api.nvim_set_hl(0, "logMacAddress",  { link = "Label",       default = true })
vim.api.nvim_set_hl(0, "logMailHeader",  { link = "Keyword",     default = true })
vim.api.nvim_set_hl(0, "logMailAddress", { link = "Underlined",  default = true })
vim.api.nvim_set_hl(0, "logMailQuoted",  { link = "Comment",     default = true })
vim.api.nvim_set_hl(0, "logFilePath",    { link = "Conditional", default = true })

vim.api.nvim_set_hl(0, "logSysCol",  { link = "Conditional", default = true })
vim.api.nvim_set_hl(0, "logSysProc", { link = "Include",     default = true })

vim.api.nvim_set_hl(0, "logOperator",   { link = "Operator", default = true })
vim.api.nvim_set_hl(0, "logBrackets",   { link = "Comment",  default = true })
vim.api.nvim_set_hl(0, "logEmptyLines", { link = "Comment",  default = true })

vim.api.nvim_set_hl(0, "logLevelEmerg",  { link = "ErrorMsg",   default = true })
vim.api.nvim_set_hl(0, "logLevelAlert",  { link = "ErrorMsg",   default = true })
vim.api.nvim_set_hl(0, "logLevelCrit",   { link = "ErrorMsg",   default = true })
vim.api.nvim_set_hl(0, "logLevelError",  { link = "ErrorMsg",   default = true })
vim.api.nvim_set_hl(0, "logLevelWarn",   { link = "WarningMsg", default = true })
vim.api.nvim_set_hl(0, "logLevelNotice", { link = "Character",  default = true })
vim.api.nvim_set_hl(0, "logLevelInfo",   { link = "Repeat",     default = true })
vim.api.nvim_set_hl(0, "logLevelDebug",  { link = "Debug",      default = true })
vim.api.nvim_set_hl(0, "logLevelTrace",  { link = "Comment",    default = true })

vim.b.current_syn = "log"
vim.opt.cpoptions = cpo_save
