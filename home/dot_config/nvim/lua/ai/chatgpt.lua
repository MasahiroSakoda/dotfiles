local ok, gpt = pcall(require, "chatgpt")
if not ok then return end

gpt.setup({
  edit_with_instructions = {
    keymap = {
      accept              = "<C-y>",
      toggle_diff         = "<C-d>",
      toggle_settings     = "<C-o>",
      cycle_windows       = "<Tab>",
      use_output_as_input = "<C-i>",
    },
  },
  chat = {
    welcome_message = "WELCOME_MESSAGE",
    loading_text    = "Loading, please wait ...",
    keymaps = {
      close           = "<C-c>",
      yank_last       = "<C-y>",
      yank_last_code  = "<C-k>",
      scroll_up       = "<C-u>",
      scroll_down     = "<C-d>",
      toggle_settings = "<C-o>",
      new_session     = "<C-n>",
      cycle_windows   = "<Tab>",
      select_session  = "<Space>",
      rename_session  = "r",
      delete_session  = "d",
      win_options = {
        winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
      },
    },
  },
  openai_params = {
    model = "gpt-3.5-turbo",
    frequency_penalty = 0,
    presence_penalty  = 0,
    max_tokens  = 300,
    temperature = 0,
    top_p = 1,
    n = 1,
  },
  openai_edit_params = {
    model = "code-davinci-edit-001",
    temperature = 0,
    top_p = 1,
    n = 1,
  },

  predefined_chat_gpt_prompts = "https://raw.githubusercontent.com/f/awesome-chatgpt-prompts/main/prompts.csv",
})
