local Window = require("tui.layout")

local input = Window:new({
  size = "75%",
  title = {
    { "Título, épico", "Title" }
  },
  border = "rounded",
  window_pos = "center",
  instant_insert = true,
  enter_to_window = true,
})

input:connect()
