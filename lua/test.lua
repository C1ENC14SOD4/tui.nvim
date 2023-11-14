local win = require("tui.layout")

local t = win:new({
  size = "50%",
  title = {
    { " Hola a todos ", "Title"}
  },
  border = "rounded",
  window_pos = "center",
  highlight = "Normal",
  instant_insert = true,
  enter_to_window = true,
})
