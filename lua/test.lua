Notification = require("tui.components.notification")

local notification = Notification:new({
  title = "Hola, ¿Qué tal?",
  content = "Vaya día de mierda.",
  border = "rounded",
})

notification:connect()
