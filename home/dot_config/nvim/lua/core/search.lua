local opt, fn = vim.opt, vim.fn

opt.hlsearch   = true
opt.incsearch  = true

opt.ignorecase = true
opt.smartcase  = true
opt.wrapscan   = true

local executable = function(e)
  return fn.executable(e) > 0
end

if executable 'rg' then
  opt.grepprg = [[rg --hidden --glob "!.git" --no-heading --smart-case --vimgrep --follow $*]]
  opt.grepformat:prepend { '%f:%l:%c:%m' }
end
