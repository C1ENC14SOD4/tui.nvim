Window = require("tui.utils.layout")

---@class Notification
---@field private title string
---@field private content string
---@field private border Border
local M = {}

---@class NotificationOptions
---@field public title string
---@field public content string
---@field public border? Border

---@param text string
---@param char string
---@param length integer
local function pad_right(text, char, length)
  for _ = #text, length do
    text = text .. char
  end
  return text
end

---@param options NotificationOptions
---@return Notification
function M:new(options)
  local obj = {}
  self.title = options.title
  self.content = options.content
  setmetatable(obj, self)
  self.__index = self
  self.window = Window:new({
    size = {
      width = 50,
      height = 5,
    },
    window_pos = "topright",
    border = options.border,
    instant_insert = false,
    enter_to_window = false,
  })
  return obj
end

function M:connect()
  self.window:connect()
  vim.api.nvim_buf_set_lines(self.window.bufnr, 0, 1, true, {
    ' ' .. self.title,
    pad_right('', "\u{2501}", 49),
    self.content,
  })
  vim.api.nvim_buf_set_option(self.window.bufnr, "modifiable", false)
end

return M
