Window = require("tui.utils.layout")

---@class Input
---@field public prompt string
---@field public size integer | string
local M = {}

---@class InputOptions
---This will be th size for width only. NOTE: height always will be 1.
---@field public size integer
---@field public prompt string
---This will be a funcion that will be executed when <CR> will be pressed. args are [text] only.
---@field public callback function
---@field public title string | Title
---@field public window_pos? Position | WindowPosition
---@field public border? Border

---@param options InputOptions
---@return Input
function M:new(options)
  local obj = {}
  setmetatable(obj, self)
  self.__index = self
  self.window = Window:new({
    size = {
      height = 1,
      width = options.size,
    },
    title = options.title,
    border = options.border or "rounded",
    window_pos = options.window_pos or "center",
    instant_insert = true,
    enter_to_window = true,
  })
  self.prompt = options.prompt
  return obj
end

function M:connect()
  self.window:connect()
  vim.bo.buftype = 'prompt'
  vim.fn.prompt_setprompt(self.window.bufnr, self.prompt)
end

return M
