-- -*-mode:lua-*- vim:ft=lua

local models = {}
vim.g.llm_index = 1

for _, m in pairs(vim.split(vim.fn.system("ollama ls | grep -v '^NAME' | tr '\t' ' ' | cut -d ' ' -f 1"), "\n")) do
  table.insert(models, string.format("%s", m))
end

-- local current_llm = function() return models[vim.g.llm_index] end

vim.api.nvim_create_user_command("AvanteSwitchLocalLLM", function()
  return vim.g.llm_index < #models and models[vim.g.llm_index+1] or models[1]
end, {})
