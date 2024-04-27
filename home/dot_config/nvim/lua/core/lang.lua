local g, fn = vim.g, vim.fn

--------------------------------------------------
-- Python environment
--------------------------------------------------
g.loaded_python_provider  = 0 -- disable Python 2.x provider
g.loaded_python3_provider = 0 -- disable Python 3.x provider

-- Python This must be here becasue it makes loading vim VERY SLOW otherwise
g.python_host_skip_check  = 1
g.python3_host_skip_check = 1

g.python3_host_prog = fn.exepath("neovim-python-host")

if vim.fn.exists("$VIRTURL_ENV") then
  g.python3_host_prog = fn.substitute(fn.system("which -a python3 | head -n2 | tail -n1"), "\n", "", "g")
else
  g.python3_host_prog = fn.substitute(fn.system("which python3"), "\n", "", "g")
end

--------------------------------------------------
-- Ruby environment
--------------------------------------------------
g.loaded_ruby_provider = 0 -- disable Ruby provider
g.ruby_host_skip_check = 1
g.ruby_host_prog       = fn.exepath("neovim-ruby-host")

--------------------------------------------------
-- Perl environment
--------------------------------------------------
g.loaded_perl_provider = 0
g.perl_host_skip_check = 1

--------------------------------------------------
-- Node.js environment
--------------------------------------------------
g.loaded_node_provider = 1
g.node_host_prog = fn.exepath("neovim-node-host")
