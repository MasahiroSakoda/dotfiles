local ok, cmdline = pcall(require, "fine-cmdline")
if not ok then return end

cmdline.setup({
  cmdline = {
    enable_keymaps = true,
  },

  popup = {
    buf_options = {
      ft = "fine-cmdline",
    },
    position = {
      row = "20%",
      col = "50%",
    },
    size = {
      width = "60%",
      height = 1,
    },
    border = {
      text = {
        top = "",
        top_align = "center",
      },
      style = { "#", "-", "#", "|", "#", "-", "#", "|" },
      highlight = "FloatBorder",
    },
    win_options = {
      winhighlight = "Normal:Normal",
    },
  },

  hook = {
    before_mount = function(input)
      input.input_props.prompt = ":"
    end,
    after_mount = function(input) end,
    set_keymaps = function(imap, feedkeys)
      imap("<Up>", cmdline.fn.complete_or_next_item)
    end
  },
})
