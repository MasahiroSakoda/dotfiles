local fn, g = vim.fn, vim.g

-- Configure Python environment
if fn.exists("$VIRTURL_ENV") == 1 then
  g.python3_host_prog = fn.substitute(fn.system("which -a python3 | head -n2 | tail -n1"), "\n", "", "g")
  local is_pynvim_installed = string.len(fn.system("pip freeze | grep pynvim")) ~= 0
  local is_pyright_installed = string.len(fn.system("pip freeze | grep pyright")) ~= 0
  if not is_pynvim_installed and not is_pyright_installed then
    print("pyright and/or pynvim not detected. Installing...")
    vim.api.nvim_exec("!pip install pynvim pyright", false)
  end
else
  g.python3_host_prog = fn.substitute(fn.system("which python3"), "\n", "", "g")
end

-- Configure Ruby environment
-- g.ruby_host
